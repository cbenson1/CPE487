# Modifications
## ball.vhd
see changes made in ball.vhd
## vga_top.xdc
added two lines of code:
<br> `+ set_property -dict { PACKAGE_PIN P17 IOSTANDARD LVCMOS33 } [get_ports { btnl }];`
<br> `+ set_property -dict { PACKAGE_PIN M17 IOSTANDARD LVCMOS33 } [get_ports { btnr }];`
