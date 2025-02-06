vcom register/core/jk_FlipFlop.vhd
vsim jkff
add wave *

force j 0 0, 1 10 -repeat 20
force k 0 0, 1 20 -repeat 40

force clk 0 0, 1 3 -repeat 6

force clear 0 


run 80