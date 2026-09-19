# Design notes - preliminary revision

## Circuit

J1 feeds a 2 A resettable PTC, series SS56 reverse-polarity diode, and SMBJ15A shunt TVS. The protected input supplies two independent TI LMR33630ADDAR synchronous buck regulators. Their enable pins are connected to the protected input; their power-good pins are intentionally unused. This is for a regulated 12 V bench/adapter source, not an automotive electrical system.

The 400 kHz reference design is the starting point: 8.2 uH for 5 V and 6.8 uH for 3.3 V, four 22 uF output capacitors per rail, 10 uF plus 220 nF local input bypass, 100 nF bootstrap, and 1 uF VCC bypass. A 100 kohm upper feedback resistor and 24.9 kohm / 43.2 kohm lower resistor set nominal outputs near 5.02 V / 3.315 V with a nominal 1 V feedback reference. These are nominal calculations, not guaranteed output tolerances.

Capacitor effective capacitance after DC bias and temperature must be checked for the exact purchased parts. Generic passive selections in the BOM are specifications, not fully released orderable parts. Confirm the PTC, terminals, capacitor and inductor drawings against the supplied custom footprints before ordering. Verify connector polarity against numbered copper pads, not just model appearance.

## Layout

Four-layer proposal: top components and routing, inner ground plane, second inner ground plane, bottom routing and ground. Local vias join ground pads to the planes; the regulator exposed pads include thermal vias. The board has input and output test points and labeled edge terminals. Fabricator stackup, copper thickness, controlled impedance, and assembly processes are not finalized.

This is a first-pass routed layout. Native clearance checking, switch-loop/return-path review, feedback-noise review, thermals, solder-mask/paste geometry, and manufacturer land-pattern confirmation remain release gates. In-pad thermal vias may require filling/capping or a revised assembly strategy. The supplied unfilled zones must be filled in KiCad before connection checks.

## Performance limitations

The nominal load targets total 5.4 W continuous and 10.8 W at simultaneous peaks, before conversion losses. Protection coordination, diode heat, PTC hold-current derating, regulator dissipation and voltage droop need evaluation under actual conditions. A TVS is not a general-purpose sustained-overvoltage disconnect; its pulse rating does not establish system surge immunity.

The specified 20 mVpp and 10 mVpp ripple values are goals, not demonstrated performance. Low-ripple sensor supplies may need additional filtering or post-regulation after measurement. No arbitrary filter is added here without reviewing its stability and transient effects. There is no claim of simulation, fabrication, power-up, oscilloscope testing, EMC compliance, or passing native ERC/DRC.

## Primary references

- TI LMR33630 datasheet: https://www.ti.com/lit/ds/symlink/lmr33630.pdf — pin assignments, reference circuits, component selection and layout guidance.
- Bourns SRP1038A inductor datasheet: https://www.bourns.com/docs/product-datasheets/srp1038a.pdf — series electrical and mechanical details.
- KiCad 9 command-line manual: https://docs.kicad.org/9.0/en/cli/cli.html — native PDF export, ERC, DRC and PCB rendering.

Reference-derived starting values are not a substitute for reviewing the completed design. Use the datasheets for the exact ordered component variants before a future fabrication release.
