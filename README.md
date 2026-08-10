Dual Clock Asynchronous FIFO
Overview
32-bit dual-clock asynchronous FIFO (Depth = 8) designed for safe clock domain crossing (CDC).

Implements:

Gray-coded read and write pointers
Two-flop synchronizers for metastability mitigation
Modular pointer handling logic
Pessimistic full and empty flag generation
Design Structure
rtl/

top.v (Top module)
fifo_mem.v (Memory block)
rptr_handler.v (Read pointer logic)
wptr_handler.v (Write pointer logic)
synchronizer.v (2-flop CDC synchronizer)
tb/

top_tb.v (Testbench)
Verification
Write clock: 20 ns
Read clock: 70 ns
Burst and boundary condition testing
Full and empty edge-case validation
Tools Used
Verilog
ModelSim
Vivado (synthesis)
