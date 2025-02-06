vcom ALU/MUX2to1.vhd
vsim work.MUX2to1

add wave *

force input 00 0, 01 10, 10 20, 11 30 -repeat 40
force sel 0 0, 1 5 -repeat 10

run 40