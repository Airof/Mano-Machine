vcom register/jk.vhd
vsim jk 
add wave *

force j 0 0, 1 10 -repeat 20
force k 0 0, 1 20 -repeat 40

force clk 0 0, 1 3 -repeat 6

force reset 0
force preset 0 


run 80