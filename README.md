# FPGA Traffic Light Controller

## Overview

This project implements a two-road traffic light controller using SystemVerilog. The design uses a finite-state machine to control the red, yellow, and green signals for two intersecting roads.

The controller was designed and simulated using AMD Vivado and is intended to be implemented on a Digilent Nexys A7 FPGA board.

## Features

- Moore finite-state machine
- Separate red, yellow, and green outputs for two roads
- 100 MHz FPGA clock input
- One-second clock-enable pulse
- Pushbutton reset
- SystemVerilog behavioral testbench
- Nexys A7 XDC pin constraints
- Verified using behavioral simulation

## Traffic Light Sequence

The controller moves through the following sequence:

1. Road A green and Road B red
2. Road A yellow and Road B red
3. Road A red and Road B green
4. Road A red and Road B yellow
5. Return to the first state

The design ensures that both roads are never green at the same time.

## Design Architecture

The project contains three main design modules.

### `clock_enable.sv`

The Nexys A7 board provides a 100 MHz clock. The clock-enable module counts clock cycles and generates a one-clock-cycle pulse every second.

The finite-state machine uses this pulse to control the timing of the traffic lights without creating a separate internally generated clock.

### `traffic_light_fsm.sv`

This module contains the finite-state machine responsible for:

- Tracking the current traffic-light state
- Determining the next state
- Controlling the six traffic-light outputs
- Returning to the initial state when reset is asserted

### `traffic_light_top.sv`

The top-level module connects the clock-enable generator to the traffic-light finite-state machine. It also exposes the clock, reset button, and LED signals as physical FPGA ports.

## Project Structure


rtl/
├── clock_enable.sv
├── traffic_light_fsm.sv
└── traffic_light_top.sv

sim/
└── traffic_light_top_tb.sv

constraints/
└── traffic_light_constraints.xdc

docs/
└── simulation_waveform.png

## Simulation

A systemVerilog testbench was created to:
- Generate the 100 MHz input clock
- Apply the reset signal
- Allow the controller to run through multiple states
- Observe all six traffic-light outputs

For simulation, the clock-enable counter limit was temporarily reduced so that state transitions could be observed without simulating 100 million clock cycles.

The counter was restored to its full hardware value before generating the FPGA bitstream.

![Behavioral simulation waveform](docs/simulation_waveform.png)

The waveform confirms that:

- Road A follows green, yellow, and red states
- Road B follows green, yellow, and red states
- The two green signals are never active simultaneously
- The sequence repeats correctly

## Challenges and Solutions

### Module-name mismatch

The clock-enable module was initially not detected by Vivado because the module name contained a spelling error.

The module declaration was corrected so that the name exactly matched the module instantiated in the top-level design.

### Port-name mismatch

Vivado reported that it could not find the `one_second_tick` port. This was resolved by checking that the port name matched exactly between the module declaration and the top-level module instance.

### Long simulation time

The original clock-enable counter waited for 100 million clock cycles before producing a tick. This is appropriate for physical hardware but made behavioral simulation unnecessarily slow.

For simulation, the counter terminal value was temporarily reduced. This allowed the complete traffic-light sequence to be viewed within a few microseconds.

### Understanding source types

The RTL modules were added as design sources, while the testbench was added separately as a simulation source. This helped separate synthesizable hardware logic from simulation-only code.

## What I Learned

Through this project, I gained experience with:

- Designing a Moore finite-state machine
- Writing synthesizable SystemVerilog
- Creating hierarchical hardware modules
- Instantiating and connecting modules
- Generating clock-enable pulses
- Writing a behavioral testbench
- Reading simulation waveforms
- Debugging module and port-name errors
- Creating FPGA pin constraints
- Running synthesis, implementation, and bitstream generation in Vivado
- Organizing an FPGA project for GitHub

## FPGA Implementation

The design successfully completed:

- Behavioral simulation
- Synthesis
- Implementation
- Bitstream generation

Physical testing on the Nexys A7 board is pending.

## Tools Used

- SystemVerilog
- AMD Vivado
- Digilent Nexys A7
- Git
- GitHub

