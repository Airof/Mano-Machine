vcom RAM/DEC2to4.vhd
vcom RAM/DEC4to16.vhd
vsim work.DEC4to16
add wave *

force W 0000 0, 0001 20, 0010 40, 0011 60, 0100 80, 0101 100, 0110 120, 0111 140, 1000 160, 1001 180, 1010 200, 1011 220, 1100 240, 1101 260, 1110 280, 1111 300 -repeat 320
force enable 0 0, 1 10 -repeat 20

run 320