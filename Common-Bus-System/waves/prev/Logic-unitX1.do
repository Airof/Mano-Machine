vcom ALU/MUX4to1.vhd
vcom ALU/Logic-unitX1.vhd
vsim work.logicX1
add wave *


force S 00 0, 01 5, 10 10, 11 15  -repeat 20
force A 0 0, 1 20 -repeat 40
force B 0 0, 1 40 -repeat 80


run 80