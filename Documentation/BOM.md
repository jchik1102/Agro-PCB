# Bill of materials

Electrical selection list for the unbuilt Rev B design. Generic passive descriptions are procurement specifications, not fixed orderable part numbers. Exact passive variants and package tolerances require confirmation before purchasing.

| References | Qty | Value / rating | Part or selection | Local footprint |
|---|---:|---|---|---|
| J1 | 1 | 12 V INPUT | KF301-5.08-2P | Terminal |
| F1 | 1 | 2 A HOLD / 30 V | MF-R200 | PTC |
| D1 | 1 | 5 A / 60 V | SS56-E3/57T | SMC |
| D2 | 1 | 15 V TVS | SMBJ15A | SMB |
| C1 | 1 | 47u / 50 V | EEU-FR1H470 | Electro |
| U1, U2 | 2 | LMR33630ADDA | LMR33630ADDAR | DDA |
| L1 | 1 | 8.2u / shielded | SRP1038A-8R2M | Inductor |
| C2, C10 | 2 | 10u / 50 V | GRM32ER71H106KA12L | C1210 |
| C3, C11 | 2 | 220n / 50 V | 0805 X7R 220nF 50V | C0805 |
| C4, C12 | 2 | 100n / 16 V | 0603 X7R 100nF 16V | C0603 |
| C5, C13 | 2 | 1u / 16 V | 0805 X7R 1uF 16V | C0805 |
| C6, C7, C8, C9, C14, C15, C16, C17 | 8 | 22u / 16 V | 1210 X7R 22uF 16V | C1210 |
| R1, R3 | 2 | 100k / 1% | 0805 100k 1% | R0805 |
| R2 | 1 | 24.9k / 1% | 0805 24.9k 1% | R0805 |
| J2 | 1 | 5 V OUTPUT | KF301-5.08-2P | Terminal |
| L2 | 1 | 6.8u / shielded | SRP1038A-6R8M | Inductor |
| R4 | 1 | 43.2k / 1% | 0805 43.2k 1% | R0805 |
| J3 | 1 | 3.3 V OUTPUT | KF301-5.08-2P | Terminal |
| TP1 | 1 | VIN_PROT | PCB test pad 2 mm | TP |
| TP4, TP5, TP6 | 3 | GND | PCB test pad 2 mm | TP |
| TP2 | 1 | OUT_5V | PCB test pad 2 mm | TP |
| TP3 | 1 | OUT_3V3 | PCB test pad 2 mm | TP |
| H1, H2, H3, H4 | 4 | M3 / NPTH | 3.2 mm non-plated hole | Hole |

## Notes

- Resistors: 1%, 0805 imperial, at least 0.125 W.
- Ceramic capacitors: X7R, 10% nominal tolerance. Effective capacitance under DC bias has not been characterized.
- U1/U2: TI DDA HSOIC-8 with grounded exposed pad, 400 kHz variant.
- L1/L2: Bourns SRP1038A; 8.2 uH and 6.8 uH. Land geometry follows the 13.6 mm overall / 3.5 x 5.4 mm pad recommendation.
- F1: Bourns MF-R200 resettable PTC, 2 A hold, 30 V class. Time-current coordination is not qualified.
- D1: SS56 family SMC Schottky, 5 A / 60 V. Cathode faces VIN_PROT.
- D2: SMBJ15A unidirectional TVS; cathode to VIN_PROT. Not qualified for vehicle transients.
- Screw terminals: generic KF301 5.08 mm pitch. Match purchased part outline and wire-entry direction before assembly.
- H1-H4 are board holes, not purchased electronic parts. Test points are exposed PCB pads.
- All supplied 3D bodies are simplified illustrations rather than manufacturer STEP models.
