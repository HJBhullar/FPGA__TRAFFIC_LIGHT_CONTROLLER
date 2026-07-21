# Design Notes

## Project Goal

Design a Moore finite state machine traffic light controller using SystemVerilog. The design will be simulated first and later implemented on an FPGA development board in the school lab.

## Inputs

| Signal | Description |
|---|---|
| clk | System clock |
| reset | Reset signal |

## Outputs

| Signal | Description |
|---|---|
| clk_100mhz | 100 MHz onboard clock |
| reset_btn | Center pushbutton reset |

## FSM States

| State | Description |
|---|---|
| A_GREEN | Main road green, side road red |
| A_YELLOW | Main road yellow transition |
| ALL_RED_1 | Road A yellow, Road B red |
| B_GREEN | Road B green, Road A red |
| B_YELLOW | Road B yellow, Road A red |
| ALL_RED_2 | Both roads red |

## Learning Goals

- Understand Moore finite state machines
- Separate sequential and combinational logic
- Use counters for timing
- Write a SystemVerilog testbench
- Simulate and verify waveforms
- Prepare the design for FPGA implementation
