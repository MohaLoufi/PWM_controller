PWM Controller with Configurable Resolution
A flexible VHDL implementation of a high-resolution PWM (Pulse Width Modulation) controller with configurable bit width and frequency settings. This project includes both the core PWM module and a comprehensive testbench for verification.
Features

Configurable PWM resolution (bit width)
Adjustable PWM frequency independent of resolution
Clean architecture with timer, counter, comparator and synchronization components
Synthesizable for FPGA and ASIC implementations
Extensively tested with multiple duty cycle configurations

The design uses an innovative approach with separate timer and counter components, allowing for precise control over both the PWM frequency and resolution. The enhanced architecture ensures clean signal generation with minimal jitter, making it suitable for various applications including motor control, LED dimming, and power regulation systems
