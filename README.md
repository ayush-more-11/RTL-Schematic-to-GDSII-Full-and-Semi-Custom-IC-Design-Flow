# RTL / Schematic-to-GDSII: Full-Custom and Semi-Custom IC Design Flow

This repository documents and preserves two practical integrated-circuit implementation flows that start from logic or transistor-level design information and end at a physical **GDSII** layout database:

1. **Full-custom flow** — transistor-level schematic/layout implementation and verification of basic standard-cell-like logic gates.
2. **Semi-custom flow** — RTL description of a vending-machine finite-state machine, synthesis into a gate-level netlist, physical implementation, signoff-oriented reports, logical-equivalence artifacts, and final GDSII output.

The repository is intended to be used as a future reference: the directory structure, input sources, scripts, constraints, generated reports, GDSII files, images, and digitized handwritten process notes are kept together so that each stage can be traced from its source to its result.

> **Important scope note:** This repository contains the design artifacts and recorded results of the flows. The exact commercial EDA installation, PDK, technology files, standard-cell libraries, extraction decks, and environment variables used to generate the results are not included in the repository. Therefore, reproducing the results requires access to a compatible EDA environment and the same or equivalent technology collateral.

---

## 1. Repository information

| Property | Value |
|---|---|
| Repository | `ayush-more-11/RTL-Schematic-to-GDSII-Full-and-Semi-Custom-IC-Design-Flow` |
| Default branch | `main` |
| Primary HDL | Verilog |
| Automation/configuration | Tcl and SDC |
| Language composition | Verilog: 68.2%; Tcl: 31.8% |
| Main physical output | GDSII (`.gds`) |
| Main verification artifacts | DRC/LVS logs, timing/area/power/gate reports, LEC netlists |

---

## 2. What the repository demonstrates

### 2.1 Full-custom IC design

In a full-custom flow, the circuit is designed at the transistor and geometry level. The designer controls the transistor arrangement, device sizing, interconnect topology, layer usage, routing, and cell geometry rather than relying entirely on pre-characterized standard cells.

This repository contains two full-custom logic-gate examples:

- A two-input **AND gate**.
- A two-input **NAND gate**.

For each gate, the repository preserves the design's physical output, visual results, and verification reports. The full-custom examples show the relationship between:

```text
Transistor-level schematic
        ↓
Symbol and schematic checks
        ↓
Simulation / functional confirmation
        ↓
Manual physical layout
        ↓
Layout-versus-schematic verification
        ↓
Design-rule verification
        ↓
GDSII stream-out
```

### 2.2 Semi-custom IC design

In a semi-custom flow, the design begins with RTL. Synthesis maps the RTL into cells from a technology library. Physical-design tools then perform floorplanning, placement, clock-tree-related processing, routing, optimization, extraction/signoff checks, and GDSII stream-out.

The semi-custom example is a **vending-machine controller** implemented as a synchronous finite-state machine. Its flow is represented as:

```text
Verilog RTL
    ↓
RTL simulation/testbench
    ↓
Elaboration and synthesis
    ↓
Gate-level netlist + generated constraints
    ↓
Timing / area / power / gate reports
    ↓
Logical-equivalence checking artifacts
    ↓
Physical implementation and signoff-oriented reports
    ↓
Final GDSII
```

---

## 3. Repository structure

```text
.
├── .gitignore
├── NOTES_Full Custom Flow.pdf
├── NOTES_Semi Custom Flow .pdf
├── Full Custom/
│   ├── AND_gate/
│   │   ├── gds/
│   │   │   └── AND_gate.gds
│   │   ├── images/
│   │   └── reports/
│   │       ├── and_drc.log
│   │       └── and_lvs.log
│   └── NAND_gate/
│       ├── gds/
│       │   └── nand_gate.gds
│       ├── images/
│       └── reports/
│           ├── NAND_DRC.log
│           └── NAND_LVS.log
└── Semi Custom/
    └── Vending Machine/
        ├── constraints/
        │   ├── vm_input_constraints.sdc
        │   └── vm_output_constraints.sdc
        ├── gds/
        │   └── vm.gds
        ├── lec/
        │   ├── vm.v
        │   └── vm_netlist.v
        ├── reports/
        │   ├── vendingMachine_preCTS.slk
        │   ├── vendingMachine_postCTS.slk
        │   ├── vendingMachine_postCTS_hold.slk
        │   ├── vm_area.rep
        │   ├── vm_gates.rep
        │   ├── vm_power.rep
        │   └── vm_timing.rep
        ├── rtl/
        │   ├── vm.v
        │   └── vm_tb.v
        └── scripts/
            ├── script_file.tcl
            └── genus.log
```

The repository may contain additional tool-generated or binary content inside the shown directories. The tables below describe the purpose of each category rather than replacing the actual files.

---

## 4. Full-custom flow

### 4.1 Full-custom AND gate

Location: [`Full Custom/AND_gate/`](Full%20Custom/AND_gate/)

The AND-gate project contains three categories of deliverables:

| Directory | Purpose |
|---|---|
| `gds/` | Final streamed-out GDSII database: `AND_gate.gds` |
| `images/` | Screenshots and visual evidence of the schematic, symbol, simulation, layout, GDSII view, area/quantitative view, DRC result, and LVS result |
| `reports/` | Verification logs: `and_drc.log` and `and_lvs.log` |

#### AND-gate image outputs

| Image | Meaning |
|---|---|
| `AND_Symbol.png` | Symbol representation of the custom AND cell |
| `AND_Schematic.png` | Transistor-level or circuit schematic view |
| `AND_Simulation.png` | Functional simulation waveform/result |
| `AND_Layout.png` | Physical mask-layout view |
| `GDS ll.png` | GDSII/layout-view representation |
| `AND_Area.png` | Area or geometry-related quantitative view |
| `AND_Quants.png` | Additional quantitative/layout information |
| `AND_No_DRC.png` | Evidence of a DRC-clean result or no reported DRC violations |
| `AND_No_LVS.png` | Evidence of an LVS-clean result or no reported LVS mismatches |

The corresponding log files should be treated as the detailed verification records; the images are convenient visual summaries for quick inspection.

### 4.2 Full-custom NAND gate

Location: [`Full Custom/NAND_gate/`](Full%20Custom/NAND_gate/)

| Directory | Contents and purpose |
|---|---|
| `gds/` | Final GDSII database: `nand_gate.gds` |
| `images/` | NAND symbol, schematic, schematic/testbench view, layout, and GDSII-view images |
| `reports/` | `NAND_DRC.log` and `NAND_LVS.log` |

#### NAND-gate image outputs

| Image | Meaning |
|---|---|
| `NAND_Symbol.png` | Symbol representation of the NAND cell |
| `NAND_Schematic.png` | NAND transistor-level/circuit schematic |
| `NAND_Sch_tb.png` | Schematic/testbench-related view |
| `NAND_Layout.png` | Physical layout view |
| `NAND_GDS.jpeg` | Rendered or captured GDSII view |

### 4.3 Full-custom verification terminology

| Check | What it verifies | Repository evidence |
|---|---|---|
| Functional simulation | Whether the circuit produces the expected logical behavior for applied inputs | Simulation images, where present |
| DRC — Design Rule Check | Whether the drawn geometry follows the foundry/technology design rules, such as minimum width, spacing, enclosure, and layer restrictions | `and_drc.log`, `NAND_DRC.log`, and result images |
| LVS — Layout Versus Schematic | Whether the extracted layout netlist matches the intended schematic netlist in connectivity and device structure | `and_lvs.log`, `NAND_LVS.log`, and result images |
| GDSII stream-out | Whether the physical design is exported into a standard mask-layout database | `AND_gate.gds`, `nand_gate.gds` |

A DRC-clean result does not by itself prove that the layout implements the intended circuit. LVS is required to establish correspondence between the layout and schematic. Likewise, an LVS-clean result does not replace electrical simulation or other signoff checks.

---

## 5. Semi-custom vending-machine design

Location: [`Semi Custom/Vending Machine/`](Semi%20Custom/Vending%20Machine/)

The vending-machine design is the repository's RTL-to-GDSII example. It contains the complete logical input, synthesis setup, timing constraints, generated reports, equivalence-checking inputs, and final physical output.

### 5.1 RTL source: `rtl/vm.v`

The top-level RTL module is named `vendingMachine`. Its interface is:

| Port | Direction | Role |
|---|---|---|
| `clk` | Input | Synchronous clock |
| `reset` | Input | Reset input |
| `two_in` | Input | Input event representing insertion of two currency units |
| `one_in` | Input | Input event representing insertion of one currency unit |
| `choco_out` | Output | Indicates chocolate/product delivery; also asserted for a change-delivery event in the RTL |
| `chng_out` | Output | Indicates change delivery |

The controller uses a three-bit state register and the following symbolic states:

| State | Encoding | Meaning |
|---|---:|---|
| `idle` | `3'b000` | Waiting for a coin/input event |
| `two_rs` | `3'b001` | One two-unit input has been received |
| `one_rs` | `3'b010` | One one-unit input has been received |
| `chocoout` | `3'b011` | Product output event |
| `chngout` | `3'b100` | Product plus change event |

The RTL contains:

- A state register updated on the positive edge of `clk` or the internally generated reset event.
- A next-state combinational block.
- A negative-edge process that controls the internal `sel` signal.
- Output decoding based on the current state.
- A default next-state path back to `idle` for unrecognized states.

The state transitions are summarized below.

| Current state | Input condition | Next state | Interpretation |
|---|---|---|---|
| `idle` | `two_in=1`, `one_in=0` | `two_rs` | Receive two-unit input |
| `idle` | `two_in=0`, `one_in=1` | `one_rs` | Receive one-unit input |
| `idle` | Both inputs equal or inactive | `idle` | Remain idle |
| `two_rs` | Two-unit input | `chngout` | Product and change event |
| `two_rs` | One-unit input | `chocoout` | Product event |
| `two_rs` | No input | `two_rs` | Hold accumulated amount |
| `one_rs` | Two-unit input | `chocoout` | Product event |
| `one_rs` | One-unit input | `two_rs` | Accumulate another unit |
| `one_rs` | No input | `one_rs` | Hold accumulated amount |
| `chocoout` | Any input | `idle` | Return to idle after product event |
| `chngout` | Any input | `idle` | Return to idle after product/change event |

The RTL implementation treats simultaneous assertion of `two_in` and `one_in` as a separate fallback case that returns to `idle`. This behavior is part of the current source and should be preserved or intentionally changed if the design is extended.

### 5.2 RTL testbench: `rtl/vm_tb.v`

The testbench instantiates `vendingMachine` as `dut` and drives:

- A clock with a 100-time-unit period: high for 50 time units and low for 50 time units.
- An initial reset interval.
- A sequence of one-unit and two-unit input events.
- A simulation stop at time 2000.

The testbench is a functional stimulus environment, not a synthesis input. The design source is `vm.v`; `vm_tb.v` is used to exercise the design before synthesis.

### 5.3 Synthesis script: `scripts/script_file.tcl`

The Tcl script records the synthesis sequence:

1. Read the slow timing library:
   `read_libs /home/install/FOUNDRY/digital/90nm/dig/lib/slow.lib`
2. Read `vm.v`.
3. Elaborate the RTL.
4. Read the input SDC constraints.
5. Run generic synthesis with medium effort.
6. Run technology mapping with medium effort.
7. Run synthesis optimization with medium effort.
8. Write the mapped Verilog netlist to `vm_netlist.v`.
9. Write generated constraints to `vm_output_constraints.sdc`.
10. Generate area, power, gate-count, and timing reports.
11. Open the tool GUI with `gui_show`.

The script is a record of the synthesis setup and is dependent on the referenced installation path, library, tool version, and current working directory.

### 5.4 Input timing constraints: `constraints/vm_input_constraints.sdc`

The input SDC defines the timing environment used during synthesis.

| Constraint | Value / target |
|---|---|
| Clock name | `clk` |
| Clock period | `2` time units |
| Clock waveform | `{0 1}` |
| Clock rise/fall transition | `0.1` |
| Clock uncertainty | `0.01` as written in the source |
| Input transition | Rise transition `0.12` on all inputs |
| Maximum input delay | `0.8` for `clk`, `two_in`, `one_in`, and `reset` relative to `clk` |
| Maximum output delay | `0.8` for `choco_out` and `chng_out` relative to `clk` |
| Output load | `0.15` on all outputs |
| Maximum fanout | `20.00` for the current design |

The source uses the command spelling `set_clock_uncertanity`. If the target tool expects the conventional `set_clock_uncertainty` spelling, this should be checked before reusing the file in another tool/version.

### 5.5 Generated output constraints: `constraints/vm_output_constraints.sdc`

`vm_output_constraints.sdc` is generated by the synthesis tool. It records the constraints associated with the mapped design, including:

- SDC version and units.
- Current design: `vendingMachine`.
- Clock definition.
- Clock transition.
- Pin loads on outputs.
- Input and output delays.
- Maximum fanout.
- Input transitions.
- Enclosed wire-load mode.

Generated constraints are useful for passing timing intent to later stages and for understanding what the synthesis tool retained or transformed from the original input constraints.

### 5.6 LEC directory

The `lec/` directory contains:

| File | Purpose |
|---|---|
| `vm.v` | Reference RTL design used for comparison |
| `vm_netlist.v` | Synthesized/mapped netlist used as the implementation-side comparison model |

Logical equivalence checking compares the RTL behavior with the synthesized netlist. It is different from DRC and LVS:

- **LEC** checks logical/functional equivalence between two netlists or representations.
- **DRC** checks physical geometry rules.
- **LVS** checks layout-extracted connectivity against the schematic/netlist.

### 5.7 Semi-custom reports

The `reports/` directory contains both synthesis-quality-of-result reports and timing snapshots.

| Report | Contents / interpretation |
|---|---|
| `vm_area.rep` | Area utilization or cell-area summary |
| `vm_gates.rep` | Mapped gate/cell composition and counts |
| `vm_power.rep` | Estimated power report |
| `vm_timing.rep` | Timing summary and critical-path information |
| `vendingMachine_preCTS.slk` | Timing/slack snapshot before clock-tree processing |
| `vendingMachine_postCTS.slk` | Timing/slack snapshot after clock-tree processing |
| `vendingMachine_postCTS_hold.slk` | Hold-timing snapshot after clock-tree processing |
| `genus.log` | Detailed synthesis-tool session log |

The `.slk` files should be read as timing/slack checkpoints. The pre-CTS and post-CTS views allow comparison of timing before and after clock-tree-related implementation. The post-CTS hold report focuses on minimum-delay/hold behavior.

### 5.8 Semi-custom GDSII output

The final physical database is:

- `Semi Custom/Vending Machine/gds/vm.gds`

GDSII is a polygon-based layout database used to transfer the physical geometry of an integrated circuit between design tools and, ultimately, toward mask-generation data preparation. The GDSII file is not a human-readable RTL or schematic file; it is the physical representation of the implemented design.

---

## 6. Full-custom versus semi-custom comparison

| Aspect | Full-custom flow | Semi-custom flow |
|---|---|---|
| Starting representation | Transistor-level schematic | RTL Verilog |
| Main design unit | Individual transistor-level gate/cell | Synthesized digital block |
| Cell construction | Manually designed devices and geometry | Technology-library cells selected by synthesis |
| Physical control | Very high; device and layout geometry are directly controlled | Constrained by library cells and automated implementation |
| Typical examples here | AND and NAND gates | Vending-machine controller |
| Functional verification | Schematic simulation | RTL testbench and synthesis/LEC artifacts |
| Physical verification | DRC and LVS | Physical implementation reports and final GDSII; additional signoff depends on the external flow |
| Output | Gate-level GDSII | Block-level GDSII |
| Main advantage | Optimization and control at device/layout level | Faster implementation and scalability for larger digital logic |
| Main trade-off | More manual effort and layout expertise | Less transistor-level freedom and stronger dependence on libraries/flow setup |

---

## 7. Meaning of the output artifacts

| Artifact type | What it represents | How to use it |
|---|---|---|
| `.v` | Verilog RTL or gate-level netlist | Read for logic behavior or mapped implementation |
| `.tcl` | Tool automation and synthesis commands | Reconstruct the documented synthesis sequence in a compatible environment |
| `.sdc` | Timing constraints | Define clocks, delays, transitions, loads, uncertainty, and fanout assumptions |
| `.gds` | Physical mask-layout database | Open in a compatible layout viewer or downstream physical-design tool |
| `.log` | Detailed tool/check output | Diagnose warnings, errors, and verification results |
| `.rep` | Structured report output | Review area, power, gates, and timing metrics |
| `.slk` | Timing/slack checkpoint | Compare timing across physical-design stages |
| `.png` / `.jpeg` | Visual capture of design or result | Quickly inspect schematic, simulation, layout, GDS, or signoff status |
| `.pdf` | Digitized process documentation | Follow the handwritten step-by-step procedures used for the flows |

---

## 8. Digitized handwritten process notes

The repository includes two PDFs that are digitized copies of the handwritten step-by-step implementation notes:

| PDF | Coverage |
|---|---|
| [`NOTES_Full Custom Flow.pdf`](NOTES_Full%20Custom%20Flow.pdf) | Full-custom schematic/layout/verification/GDSII process |
| [`NOTES_Semi Custom Flow .pdf`](NOTES_Semi%20Custom%20Flow%20.pdf) | Semi-custom RTL, synthesis, constraints, physical implementation, verification, and GDSII process |

These PDFs are the procedural companion to the machine-readable project artifacts. Use them when you need the exact sequence of interactive or tool-specific actions, while using the directories and files as the corresponding implementation evidence.

### Recommended way to use the PDFs

1. Open the PDF for the desired flow.
2. Follow its steps in order.
3. At each stage, compare the expected artifact with the matching repository directory.
4. Use the images as visual checkpoints.
5. Use the logs and reports as detailed verification records.
6. Use the final `.gds` file to inspect the physical result.

The PDFs should be considered documentation of the demonstrated process. They do not remove the need for a compatible PDK, technology library, design-rule deck, extraction/LVS setup, license, and tool environment.

---

## 9. Suggested inspection order for future reference

### To study the full-custom flow

1. Read `NOTES_Full Custom Flow.pdf`.
2. Open `Full Custom/AND_gate/images/AND_Schematic.png` and `AND_Simulation.png`.
3. Inspect `Full Custom/AND_gate/images/AND_Layout.png` and `GDS ll.png`.
4. Review `Full Custom/AND_gate/reports/and_drc.log`.
5. Review `Full Custom/AND_gate/reports/and_lvs.log`.
6. Open `Full Custom/AND_gate/gds/AND_gate.gds` in a compatible viewer.
7. Repeat the same process for `Full Custom/NAND_gate/`.

### To study the semi-custom flow

1. Read `NOTES_Semi Custom Flow .pdf`.
2. Read `Semi Custom/Vending Machine/rtl/vm.v`.
3. Read `vm_tb.v` to understand the stimulus sequence.
4. Read the input SDC files and identify the timing assumptions.
5. Read `scripts/script_file.tcl` from top to bottom.
6. Inspect `scripts/genus.log` for the recorded synthesis session.
7. Compare `vm.v` and `lec/vm_netlist.v`.
8. Review `vm_area.rep`, `vm_gates.rep`, `vm_power.rep`, and `vm_timing.rep`.
9. Compare the pre-CTS and post-CTS `.slk` timing checkpoints.
10. Inspect the final `gds/vm.gds` file.

---

## 10. Reuse and reproduction checklist

Before attempting to rerun either flow, verify all of the following:

- A compatible EDA tool installation is available.
- The required 90 nm digital library and technology files are available.
- The referenced slow library path is corrected for the local machine.
- The required PDK, layer map, design-rule deck, extraction deck, and LVS setup are available.
- Tool licenses and environment variables are configured.
- The working directory is set so relative file names resolve correctly.
- The design is opened using the correct technology units and layer definitions.
- Timing units and clock assumptions in the SDC files are understood.
- Generated files are kept separate from source files when rerunning experiments.
- DRC, LVS, LEC, timing, area, and power results are checked rather than assumed from successful tool completion.

For the semi-custom flow specifically, confirm that the library used for synthesis is consistent with the library and technology used during physical implementation. A mapped netlist and a GDSII file generated from incompatible libraries or technology assumptions should not be treated as a valid implementation result.

---

## 11. Verification responsibilities

The repository contains evidence for several different verification questions. They should not be conflated:

| Question | Appropriate evidence |
|---|---|
| Does the RTL or schematic behave as intended? | Simulation/testbench results |
| Does synthesis preserve the intended logic? | LEC inputs/results and netlist review |
| Is the geometry legal for the technology? | DRC log/result |
| Does the physical layout represent the intended circuit? | LVS log/result |
| Does the design meet timing assumptions? | SDC plus timing/slack reports |
| What are the implementation costs? | Area, power, and gate reports |
| What physical database is delivered? | Final GDSII file |

A complete signoff decision should consider all applicable checks together.

---

## 12. Limitations and interpretation notes

- The repository is a learning/reference archive as well as a collection of generated design artifacts.
- Exact tool commands and GUI steps may vary with EDA-tool version, PDK release, operating system, and installation path.
- The synthesis Tcl script references an absolute library path under `/home/install/FOUNDRY/...`; this path is environment-specific.
- The generated output SDC is tool-produced and should be regenerated when the RTL, library, timing assumptions, or synthesis flow changes.
- The reports and images describe the recorded run; they should not be assumed to represent a newly rerun implementation unless the flow is executed again.
- Binary GDSII files require a compatible layout viewer; they cannot be meaningfully reviewed as plain text.
- The full-custom and semi-custom examples use different abstraction levels and should be compared as complementary flows, not as identical implementations of the same circuit.

---

## 13. Summary

This repository is a consolidated reference for moving from design intent to physical IC layout through two complementary approaches:

- **Full-custom:** create and verify transistor-level AND and NAND gates, draw their layouts, run DRC/LVS-oriented checks, and preserve the final GDSII databases.
- **Semi-custom:** describe a vending-machine controller in Verilog, test it, synthesize it with timing constraints, preserve the mapped netlist and reports, maintain LEC artifacts, and deliver a final GDSII database.

The two digitized handwritten PDFs explain the procedural steps, while the source files, scripts, images, logs, reports, and GDSII files provide the corresponding technical record. Together, they make it possible to understand not only **what** was produced, but also **how** each flow progresses from schematic or RTL to a physical GDSII representation.
