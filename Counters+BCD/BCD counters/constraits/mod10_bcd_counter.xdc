## Clock
set_property PACKAGE_PIN <CLOCK_PIN> [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]

## Reset
set_property PACKAGE_PIN <RESET_PIN> [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## BCD Output Q[0]
set_property PACKAGE_PIN <Q0_PIN> [get_ports {q[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {q[0]}]

## BCD Output Q[1]
set_property PACKAGE_PIN <Q1_PIN> [get_ports {q[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {q[1]}]

## BCD Output Q[2]
set_property PACKAGE_PIN <Q2_PIN> [get_ports {q[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {q[2]}]

## BCD Output Q[3]
set_property PACKAGE_PIN <Q3_PIN> [get_ports {q[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {q[3]}]