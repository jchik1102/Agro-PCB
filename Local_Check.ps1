param([string]$KiCadCli = "")
$ErrorActionPreference = "Stop"
$projectRoot = $PSScriptRoot
if (-not $KiCadCli) {
    $found = Get-Command kicad-cli.exe -ErrorAction SilentlyContinue
    if ($found) { $KiCadCli = $found.Source }
    else {
        $candidates = @(Get-ChildItem -Path "$env:ProgramFiles\KiCad\*\bin\kicad-cli.exe" -ErrorAction SilentlyContinue | Sort-Object FullName -Descending)
        if ($candidates.Count -gt 0) { $KiCadCli = $candidates[0].FullName }
    }
}
if (-not $KiCadCli -or -not (Test-Path -LiteralPath $KiCadCli)) {
    throw 'KiCad CLI not found. Install KiCad 9 or newer, or rerun with -KiCadCli and the full path to kicad-cli.exe.'
}
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss_fff'
$out = Join-Path $projectRoot "Local_Output\$stamp"
New-Item -ItemType Directory -Path $out -Force | Out-Null
$sch = Join-Path $projectRoot 'Agrobot_Power_Board.kicad_sch'
$pcb = Join-Path $projectRoot 'Agrobot_Power_Board.kicad_pcb'
$log = Join-Path $out 'run_log.txt'
function Invoke-KiCad {
    param([string]$Label, [string[]]$CliArgs)
    Write-Host "Running $Label ..."
    Add-Content -LiteralPath $log -Value "`r`n=== $Label ==="
    # Older Windows PowerShell turns native stderr into ErrorRecords.
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $messages = & $KiCadCli @CliArgs 2>&1
        $code = $LASTEXITCODE
        $messages | Out-String | Add-Content -LiteralPath $log
        Add-Content -LiteralPath $log -Value "Exit code: $code"
        Write-Host "$Label exit code: $code (see run_log.txt)"
    } finally { $ErrorActionPreference = $previousPreference }
}
Push-Location $projectRoot
try {
    'Fill PCB zones with B and save in PCB Editor before this run. Exit code 5 from ERC/DRC means reported violations, not a passing result.' | Set-Content -LiteralPath $log
    Invoke-KiCad -Label 'Version' -CliArgs @('--version')
    Invoke-KiCad -Label 'Schematic PDF' -CliArgs @('sch','export','pdf','--output',(Join-Path $out 'Schematic_Native.pdf'),$sch)
    Invoke-KiCad -Label 'ERC' -CliArgs @('sch','erc','--format','json','--exit-code-violations','--output',(Join-Path $out 'ERC.json'),$sch)
    Invoke-KiCad -Label 'DRC' -CliArgs @('pcb','drc','--format','json','--exit-code-violations','--output',(Join-Path $out 'DRC.json'),$pcb)
    Invoke-KiCad -Label 'PCB 3D render' -CliArgs @('pcb','render','--output',(Join-Path $out 'PCB_Native.png'),'--width','1600','--height','1000','--side','top','--background','opaque','--quality','high',$pcb)
    $archive = Join-Path $projectRoot "Diagnostics_$stamp.zip"
    Compress-Archive -Path (Join-Path $out '*') -DestinationPath $archive
    Write-Host "`r`nFinished collecting reports. This does not mean ERC/DRC passed."
    Write-Host "Send back: $archive"
    Write-Host 'Reports may include local file paths; review before sharing.'
} finally { Pop-Location }
