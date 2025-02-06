vcom ALU/MUX4to1.vhd
vcom ALU/Logic-unitX1.vhd
vcom ALU/Logic-unit.vhd
vsim work.logic
add wave *



force sel 00 0, 01 5, 10 10, 11 15  -repeat 20
force A 0000000011111111 0, 1111000011110000 20 -repeat 40
force B 1111111100000000 0, 1010101010101010 40 -repeat 80


run 80
