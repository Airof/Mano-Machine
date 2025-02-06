vcom ALU/MUX2to1.vhd
vcom ALU/Shift-register.vhd
vcom ALU/MUX4to1.vhd
vcom ALU/Logic-unitX1.vhd
vcom ALU/Logic-unit.vhd
vcom ALU/FullAdder.vhd
vcom ALU/Arithmatic-unit.vhd

vsim work.ALU
add wave *  

force A 1111111100000000 0ns, 0011110111011100 100ns, 0011101010011100 200ns, 0000001111111111 300ns -repeat 400ns
force B 0000000011111111 0ns, 0000001111111111 200ns -repeat 400ns

force cin 0 0ns, 1 50ns -repeat 100ns
force ALU/S 0000 0ns, 0001 20ns, 0010 40ns, 0011 60ns, 0100 80ns, 0101 100ns, 0110 120ns, 0111 140ns, 1000 160ns, 1001 180ns, 1010 200ns, 1011 220ns, 1100 240ns, 1101 260ns, 1110 280ns, 1111 300ns -repeat 320ns

run 4000ns