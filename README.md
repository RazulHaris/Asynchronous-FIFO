# Dual-Clock Asynchronous FIFO

A **32-bit dual-clock asynchronous FIFO** with a depth of **8 entries**, designed for safe and reliable **clock-domain crossing (CDC)** between independent clock domains.

## Overview

This project implements an asynchronous FIFO using industry-standard CDC techniques to safely transfer data between two unrelated clock domains.

### Key Features

* **32-bit data width**
* **FIFO depth of 8 entries**
* Independent read and write clock domains
* **Gray-coded read and write pointers**
* **Two-flop synchronizers** for metastability mitigation
* Modular pointer handling logic
* **Pessimistic full and empty flag generation**
* Supports burst transfers and boundary conditions
* Designed for synthesis and FPGA implementation

## Design Architecture

The FIFO is divided into separate read-domain and write-domain logic. Since the read and write clocks are asynchronous to each other, the corresponding pointers are converted to Gray code and synchronized across clock domains using two-stage synchronizers.

```text
                 WRITE CLOCK DOMAIN
                 ┌───────────────────┐
                 │                   │
   wr_en ───────►│  Write Pointer    │
                 │    Handler        │
                 └────────┬──────────┘
                          │
                    Gray-coded
                   Write Pointer
                          │
                          ▼
                 ┌───────────────────┐
                 │  2-FF Synchronizer│
                 └────────┬──────────┘
                          │
                          ▼
                    Read Domain


                 ┌───────────────────┐
                 │    FIFO Memory    │
                 │   32-bit × 8      │
                 └───────────────────┘


                 READ CLOCK DOMAIN
                 ┌───────────────────┐
                 │                   │
   rd_en ───────►│   Read Pointer    │
                 │     Handler       │
                 └────────┬──────────┘
                          │
                    Gray-coded
                    Read Pointer
                          │
                          ▼
                 ┌───────────────────┐
                 │  2-FF Synchronizer│
                 └────────┬──────────┘
                          │
                          ▼
                   Write Domain
```

## Repository Structure

```text
dual-clock-asynchronous-fifo/
│
├── rtl/
│   ├── top.v
│   ├── fifo_mem.v
│   ├── rptr_handler.v
│   ├── wptr_handler.v
│   └── synchronizer.v
│
├── tb/
│   └── top_tb.v
│
└── README.md
```

### RTL Modules

| Module           | Description                                      |
| ---------------- | ------------------------------------------------ |
| `top.v`          | Top-level FIFO module integrating all components |
| `fifo_mem.v`     | 32-bit × 8 FIFO memory                           |
| `rptr_handler.v` | Read pointer, read enable, and empty flag logic  |
| `wptr_handler.v` | Write pointer, write enable, and full flag logic |
| `synchronizer.v` | Two-flop synchronizer for CDC pointer transfer   |

### Testbench

`top_tb.v` provides functional verification of the asynchronous FIFO, including:

* Normal write and read operations
* Burst transfers
* FIFO full condition
* FIFO empty condition
* Boundary conditions
* Independent read/write clock operation
* Data integrity checking

## Pointer Architecture

The FIFO uses **binary pointers for memory addressing** and **Gray-coded pointers for clock-domain crossing**.

Gray coding ensures that only **one bit changes between consecutive pointer values**, reducing the possibility of incorrect pointer sampling when transferring the pointer between asynchronous clock domains.

The synchronized Gray-coded pointers are then used to generate the FIFO's `full` and `empty` status flags.

## Full and Empty Detection

The FIFO uses **pessimistic flag generation** to safely handle asynchronous pointer synchronization.

### Empty Condition

The FIFO is considered empty when the current read pointer matches the synchronized write pointer.

```text
Read Pointer == Synchronized Write Pointer
                         ↓
                      EMPTY
```

### Full Condition

The FIFO is considered full when the next write pointer reaches the corresponding synchronized read-pointer position indicating that all FIFO entries are occupied.

```text
Next Write Pointer == Adjusted Synchronized Read Pointer
                              ↓
                            FULL
```

This approach provides safe operation despite the latency introduced by the two-flop synchronizers.

## Verification

The design was verified using independent asynchronous clocks:

```text
Write Clock : 20 ns
Read Clock  : 70 ns
```

The testbench performs burst transfers and specifically exercises FIFO boundary conditions, including:

* Empty FIFO read attempts
* Full FIFO write attempts
* Transition into and out of the empty state
* Transition into and out of the full state
* Continuous/burst writes
* Continuous/burst reads
* Data ordering and integrity

## Tools Used

* **Verilog HDL** — RTL design
* **ModelSim** — Functional simulation and verification
* **Xilinx Vivado** — RTL synthesis and design analysis

## Learning Objectives

This project demonstrates practical implementation of:

* Asynchronous FIFO architecture
* Clock-domain crossing (CDC)
* Metastability mitigation
* Gray-code pointer synchronization
* FIFO full/empty detection
* Multi-clock RTL design
* RTL simulation and verification
* FPGA synthesis

## Author

**Razul Haris**
