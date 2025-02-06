vcom RAM/DEC2to4.vhd
vcom RAM/DEC4to16.vhd
vcom RAM/DEC12to4096.vhd
vsim work.DEC12to4096
add wave *

force addr  100000000011 0
force enable 1 0

run 1