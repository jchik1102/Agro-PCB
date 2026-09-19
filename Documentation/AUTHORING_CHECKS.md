# Authoring checks

- Native S-expression structures parsed by the authoring script.
- Four copper layers declared: F.Cu, In1.Cu, In2.Cu, B.Cu.
- Every assigned schematic pin compared with its PCB net, except intentionally unused PG outputs.
- All non-ground multi-pad nets have connected track/via paths in the generated geometry.
- Ground pads use through-hole connections or local vias to the ground zones.
- Symbols, footprints, and simplified VRML bodies are included locally.

These checks are not KiCad ERC/DRC and do not certify layout clearance or electrical performance. KiCad has not opened these files in the authoring environment. Ground zones are defined but must be filled in KiCad. Run the supplied local script and return its reports for review. Native exports should be used as the final source of truth.
