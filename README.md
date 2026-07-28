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
