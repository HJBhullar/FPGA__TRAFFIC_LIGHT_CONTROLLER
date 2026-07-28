# FPGA Traffic Light Controller

## Overview

This project implements a two-road traffic light controller using SystemVerilog. The design uses a Moore finite-state machine to control the red, yellow, and green lights for two intersecting roads.

The controller was designed, simulated, synthesized, and implemented using AMD Vivado. It targets the Digilent Nexys A7 FPGA development board.

## Features

- Moore finite-state machine
- Separate red, yellow, and green outputs for two roads
- 100 MHz FPGA clock input
- One-second clock-enable pulse
- Pushbutton reset
- Modular SystemVerilog design
- SystemVerilog behavioral testbench
- Nexys A7 XDC pin constraints
- Behavioral simulation verification
- Successful synthesis, implementation, and bitstream generation

## Traffic Light Sequence

The controller moves through the following sequence:

1. Road A green and Road B red
2. Road A yellow and Road B red
3. Road A red and Road B green
4. Road A red and Road B yellow
5. Return to the first state

The design ensures that Road A and Road B are never green at the same time.

## State Table

| State | Road A Red | Road A Yellow | Road A Green | Road B Red | Road B Yellow | Road B Green |
|---|---:|---:|---:|---:|---:|---:|
| Road A Green | 0 | 0 | 1 | 1 | 0 | 0 |
| Road A Yellow | 0 | 1 | 0 | 1 | 0 | 0 |
| Road B Green | 1 | 0 | 0 | 0 | 0 | 1 |
| Road B Yellow | 1 | 0 | 0 | 0 | 1 | 0 |

## Design Architecture

The project contains three main RTL modules.

### `clock_enable.sv`

The Nexys A7 board provides a 100 MHz clock signal.

The clock-enable module counts 100 million clock cycles and produces a one-clock-cycle pulse approximately once every second.

The finite-state machine uses this pulse as an enable signal. This allows the entire design to remain synchronized to the original 100 MHz FPGA clock instead of creating another internal clock.

### `traffic_light_fsm.sv`

This module implements the Moore finite-state machine responsible for:

- Storing the current traffic-light state
- Determining the next state
- Controlling all six traffic-light outputs
- Moving to the next state when `one_second_tick` is asserted
- Returning to the initial state when reset is asserted

Because this is a Moore finite-state machine, the traffic-light outputs depend only on the current state.

### `traffic_light_top.sv`

The top-level module connects the clock-enable generator to the traffic-light finite-state machine.

It exposes the following signals as external FPGA ports:

- 100 MHz input clock
- Reset pushbutton
- Road A red, yellow, and green LEDs
- Road B red, yellow, and green LEDs

## Project Structure

```text
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

README.md
```

## Simulation

A SystemVerilog testbench was created to:

- Generate the 100 MHz input clock
- Apply the reset signal
- Instantiate the complete top-level design
- Allow the controller to run through multiple states
- Observe all six traffic-light outputs
- Verify the repeating traffic-light sequence

For behavioral simulation, the clock-enable counter limit was temporarily reduced. This allowed state transitions to be observed without simulating 100 million clock cycles for every traffic-light transition.

The counter was restored to its full hardware value before synthesis, implementation, and bitstream generation.

![Behavioral simulation waveform](docs/simulation_waveform.png)

The waveform confirms that:

- Road A changes through green, yellow, and red
- Road B changes through green, yellow, and red
- Road A and Road B are never green simultaneously
- The sequence repeats correctly
- Reset places the controller in its initial state

## Reset Behaviour

When the reset button is asserted, the controller returns to its initial safe state:

```text
Road A: Green
Road B: Red
```

The clock-enable counter is also cleared during reset.

## FPGA Pin Constraints

The XDC constraints file connects the top-level SystemVerilog ports to physical components on the Nexys A7 board.

The constraints include:

- The onboard 100 MHz oscillator
- A pushbutton for reset
- Six onboard LEDs for the traffic-light outputs
- The LVCMOS33 I/O electrical standard
- A 10 ns timing constraint for the 100 MHz clock

Only top-level module ports require physical pin assignments. Internal signals such as the counter, current state, and `one_second_tick` do not appear in the XDC file.

## Vivado Design Flow

The following Vivado design flow was completed:

1. Create the SystemVerilog RTL modules
2. Connect the modules in the top-level design
3. Create a SystemVerilog testbench
4. Run behavioral simulation
5. Verify the output waveforms
6. Add the Nexys A7 XDC constraints
7. Run synthesis
8. Run implementation
9. Generate the FPGA bitstream
10. Program and test the Nexys A7 board

## Challenges and Solutions

### Module-name mismatch

The clock-enable module was initially not detected by Vivado because its module declaration contained a spelling error.

The module name was corrected so that it exactly matched the name used when the module was instantiated in `traffic_light_top.sv`.

### Port-name mismatch

Vivado reported that it could not find the `one_second_tick` port.

This was resolved by checking that the port name matched exactly between the clock-enable module declaration and the top-level module instance.

SystemVerilog port and module names are case-sensitive and must be spelled consistently.

### Long simulation time

The hardware clock-enable counter waits for 100 million clock cycles before generating a pulse.

Although this produces the correct one-second timing on the physical FPGA, it makes behavioral simulation unnecessarily slow.

For simulation, the counter limit was temporarily reduced so the complete traffic-light sequence could be viewed within a few microseconds.

The counter was changed back to its full hardware value before generating the bitstream.

### Understanding source types

The synthesizable RTL modules were added as design sources.

The testbench was added separately as a simulation source because it contains simulation-only constructs such as:

```systemverilog
initial
forever
#5
$finish
```

These testbench constructs are useful for simulation but are not implemented as physical FPGA hardware.

### Organizing a hierarchical design

The project was divided into separate modules instead of placing all logic in one file.

This improved readability, debugging, testing, and reuse.

## What I Learned

Through this project, I gained experience with:

- Designing a Moore finite-state machine
- Writing synthesizable SystemVerilog
- Creating sequential and combinational logic
- Using `always_ff` and `always_comb`
- Creating hierarchical hardware modules
- Instantiating and connecting modules
- Generating a clock-enable pulse
- Dividing a 100 MHz FPGA clock
- Writing a SystemVerilog behavioral testbench
- Generating a simulated clock signal
- Applying reset signals in simulation
- Reading and interpreting digital waveforms
- Debugging module-name and port-name errors
- Understanding design sources and simulation sources
- Creating FPGA XDC pin constraints
- Running synthesis in Vivado
- Running implementation in Vivado
- Generating an FPGA bitstream
- Organizing an FPGA project for GitHub
- Documenting engineering design decisions and debugging steps

## FPGA Implementation Status

The design successfully completed:

- Behavioral simulation
- Synthesis
- Implementation
- Bitstream generation

Physical testing on the Digilent Nexys A7 FPGA board is pending.

## Hardware Testing Plan

During physical testing, the following items will be verified:

- The six onboard LEDs follow the expected traffic-light sequence
- Road A and Road B are never green simultaneously
- Each state remains active for the expected duration
- The traffic-light sequence repeats continuously
- Pressing the reset button returns the design to Road A green and Road B red

## Tools Used

- SystemVerilog
- AMD Vivado
- Digilent Nexys A7
- AMD/Xilinx Artix-7 FPGA
- Git
- GitHub

## Future Improvements

Possible future improvements include:

- Adjustable green and yellow timing
- A dedicated all-red safety state
- Pedestrian crossing inputs
- Pedestrian walk and stop signals
- Vehicle-detection sensors
- Emergency-vehicle priority
- Seven-segment display countdown timers
- Formal assertions for traffic-light safety
- A self-checking SystemVerilog testbench
- Parameterized timing values

## Author

**Harmanjit Singh Bhullar**

Electrical Engineering student at Carleton University with an interest in FPGA development, digital logic design, RTL design, and semiconductor engineering.
