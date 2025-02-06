vcom ALU/FullAdder.vhd
vcom ALU/MUX4to1.vhd
vcom ALU/Arithmatic-unit.vhd
vsim work.Arithmatic
add wave *


force A 1111000011110000
force B 1111000000001111

force sel 00 0, 01 20, 10 40 , 11 60 -repeat 80
force cin 0 0, 1 10 -repeat 20

run 80