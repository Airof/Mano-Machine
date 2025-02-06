vcom register/core/jk_FlipFlop.vhd
vcom register/core/7bit-register.vhd

vsim reg7
add wave *

force data_in 7'h4
force clear 0
force load 0
force count 0
force clk 0 0ns, 1 0.5ns -repeat 1ns
run 1ns

force load 1
run 1ns

force load 0
force clear 1 
run 1ns 

force clear 0
force load 1
run 1ns

force load 0 
run 1ns



