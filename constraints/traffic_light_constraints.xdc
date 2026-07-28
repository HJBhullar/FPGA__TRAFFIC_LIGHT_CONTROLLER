## 100 MHz clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk_100mhz}]
create_clock -add -name sys_clk_pin -period 10.000 -waveform {0 5} [get_ports {clk_100mhz}]

## Centre pushbutton used as reset
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {reset_btn}]

## Road A LEDs: LED0, LED1 and LED2
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports {road_a_red}]
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports {road_a_yellow}]
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports {road_a_green}]

## Road B LEDs: LED3, LED4 and LED5
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports {road_b_red}]
set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports {road_b_yellow}]
set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports {road_b_green}]