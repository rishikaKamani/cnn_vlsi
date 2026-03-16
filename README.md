# CNN VLSI — FPGA-Based CNN Inference Accelerator

A Verilog implementation of a CNN inference pipeline targeting the Xilinx Artix-7 200T FPGA (`xc7a200tfbg676-2`), built and synthesized using Vivado 2023.1. The design performs binary image classification (normal vs. leukemia cell detection) on 16×16 grayscale images.

---

## Architecture

```
Image Memory (.mem) → MAC Unit → ReLU → MaxPool → FC Layer → class0 / class1
        ↓
   avg_pixel ──────────────────────────────────────────────→ Predictor → prediction
```

### Modules

| Module | File | Description |
|---|---|---|
| `top_module` | `top_module.v` | Top-level. Streams pixels from memory, computes average, wires the pipeline. |
| `mac_unit` | `mac_unit.v` | Registered multiply-accumulate: `result = a × b` |
| `relu` | `relu.v` | Combinational ReLU activation |
| `maxpool` | `maxpool.v` | Combinational 2×2 max pooling |
| `fc_layer` | `fc_layer.v` | Fully-connected layer (outputs class scores) |
| `conv3x3` | `conv3x3.v` | Sequential 3×3 convolution, 9-cycle accumulation with `done` flag |
| `predictor` | `predictor.v` | Thresholds `avg_pixel` > 170 → `prediction = 1` |
| `image_loader` | `image_loader.v` | Standalone pixel streamer with hardcoded image data |

---

## Project Structure

```
fpgasr1.srcs/
├── sources_1/new/       # RTL source files
│   ├── top_module.v
│   ├── conv3x3.v
│   ├── fc_layer.v
│   ├── mac_unit.v
│   ├── maxpool.v
│   ├── relu.v
│   ├── image_loader.v
│   └── predictor.v
├── sim_1/new/           # Testbenches
│   ├── top_module_tb.v
│   └── tb_top.v
└── constrs_1/new/       # XDC constraints
    └── constraint.xdc

fpgasr1.ip_user_files/mem_init_files/   # Image and weight memory files
├── dataset1–5.mem       # Test image datasets
├── image1–6.mem         # Labeled image samples
├── normal.mem / normal1.mem
└── cnn_weights.mem      # CNN weights (not yet wired)
```

---

## IO / Pin Constraints

| Signal | Pin | Standard | Notes |
|---|---|---|---|
| `clk` | N11 | LVCMOS33 | 100 MHz (10 ns period) |
| `prediction` | J3 | LVCMOS33 | LED output |
| `class0` | — | — | Unassigned (DRC warning suppressed) |
| `class1` | — | — | Unassigned (DRC warning suppressed) |

---

## How It Works

1. On reset, the image memory is loaded from a `.mem` file (`dataset1.mem` by default).
2. Each clock cycle, one pixel is read and passed through the MAC unit (multiplied by weight = 3).
3. The result passes through ReLU → MaxPool → FC layer, producing two class scores (`class0`, `class1`).
4. In parallel, a running pixel sum is accumulated. After all 256 pixels are processed, the average is computed.
5. The `predictor` compares `avg_pixel` against a threshold of 170. If above → `prediction = 1` (leukemia), else `prediction = 0` (normal).

---

## Simulation

Run the testbench in Vivado Simulator (xsim):

- Clock: 10 ns period
- Reset held for 20 ns, then released
- Simulation runs for 5 µs

> **Note:** `top_module_tb.v` currently connects a `cnn_output [7:0]` port that does not match the actual `top_module` interface (`class0`, `class1`, `prediction`). The testbench needs to be updated to match.

---

## Build Status

| Step | Status |
|---|---|
| Synthesis | Complete (`synth_1/top_module.dcp`) |
| Implementation | Complete (`impl_1/top_module_routed.dcp`) |
| Bitstream | Generated (`write_bitstream.pb`) |

---

## Known Limitations / TODO

- `conv3x3` is implemented but **not instantiated** in `top_module` — the convolution layer is currently bypassed.
- `cnn_weights.mem` exists but is **not loaded** anywhere in the design.
- `image_loader.v` is a standalone module and **not connected** to the top-level pipeline.
- The FC layer is a placeholder — `class0 = in_data`, `class1 = in_data >> 1`.
- The predictor uses a fixed pixel-average heuristic rather than learned weights.
- Testbench port mismatch needs to be resolved before simulation can run.

---

## Target Device

- Part: `xc7a200tfbg676-2` (Xilinx Artix-7 200T)
- Tool: Vivado 2023.1
