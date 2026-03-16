## CLOCK
set_property PACKAGE_PIN N11 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 [get_ports clk]

## LED FOR PREDICTION
set_property PACKAGE_PIN J3 [get_ports prediction]
set_property IOSTANDARD LVCMOS33 [get_ports prediction]

## Allow unused ports (class0 and class1)
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]