vcom RAM/DEC2to4.vhd
vsim work.DEC2to4
add wave *

force W 00 0, 01 10, 10 20, 11 30 -repeat 40
force enable 0 0, 1 5 -repeat 10

run 40