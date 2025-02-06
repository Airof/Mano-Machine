vcom ALU/MUX4to1.vhd
vcom ALU/MUX2to1.vhd
vcom BUS/MUX8to1.vhd

vsim work.MUX8to1

add wave *



force input 8'hf0 0
force input 8'h0f 8
force input 8'hAA 16
force input 8'h4c 24
force input 8'hf2 32
force input 8'h00 40

force sel 000 0, 001 1, 010 2, 011 3, 100 4, 101 5, 110 6, 111 7  -repeat 8

run 45