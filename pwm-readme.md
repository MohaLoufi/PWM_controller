# Configurable PWM Controller

## Overview
This repository contains a flexible VHDL implementation of a high-resolution PWM (Pulse Width Modulation) controller with configurable bit width and frequency settings. The design features an enhanced architecture that provides precise control over both PWM frequency and resolution.

## Architecture

![PWM Controller Block Diagram](pwm_architecture.png)

The PWM controller consists of four primary components:

1. **Timer** - Controls the overall PWM period based on a configurable FINAL_VALUE parameter
2. **UP Counter** - Increments through values with configurable R-bit resolution
3. **Comparator** - Compares the counter value against the duty cycle input
4. **D Flip-Flop** - Synchronizes the output to produce a clean PWM signal

This architecture enables independent control of PWM frequency and resolution, allowing for flexible adaptation to various application requirements.

## Features
- Configurable PWM resolution (bit width)
- Adjustable PWM frequency independent of resolution
- Clean synchronous design with minimal jitter
- Synthesizable for FPGA and ASIC implementations
- Comprehensive testbench included

## Files
- `pwm.vhd` - Core PWM module implementation
- `pwm_tb.vhd` - Testbench for verification with various duty cycle settings

## Applications
- Motor control
- LED dimming
- Power regulation systems
- Signal generation
- Audio applications

## Testing
The included testbench (`pwm_tb.vhd`) evaluates the PWM controller with various duty cycle settings (0%, 25%, 50%, 75%, and 100%) to verify proper operation across the full range of possible values.
