# Design Notes

## Project Goal

Design a Moore finite state machine traffic light controller using SystemVerilog. The design will be simulated first and later implemented on an FPGA development board in the school lab.

## Inputs

| Signal | Description |
|---|---|
| clk | System clock |
| reset | Reset signal |
| ped_button | Pedestrian crossing request |
| emergency | Emergency override |

## Outputs

| Signal | Description |
|---|---|
| main_red | Main road red light |
| main_yellow | Main road yellow light |
| main_green | Main road green light |
| side_red | Side road red light |
| side_yellow | Side road yellow light |
| side_green | Side road green light |
| ped_walk | Pedestrian walk signal |

## FSM States

| State | Description |
|---|---|
| MAIN_GREEN | Main road green, side road red |
| MAIN_YELLOW | Main road yellow transition |
| SIDE_GREEN | Side road green, main road red |
| SIDE_YELLOW | Side road yellow transition |
| PED_WALK | Both roads red, pedestrian walk active |
| EMERGENCY | Both roads red, emergency mode active |

## Learning Goals

- Understand Moore finite state machines
- Separate sequential and combinational logic
- Use counters for timing
- Write a SystemVerilog testbench
- Simulate and verify waveforms
- Prepare the design for FPGA implementation
