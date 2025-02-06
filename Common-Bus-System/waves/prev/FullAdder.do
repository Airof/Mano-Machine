vcom ALU/FullAdder.vhd
vsim work.FullAdder
add wave *

force a 0 0, 1 10 -repeat 20
force b 0 0, 1 20 -repeat 40
force cin 0 0, 1 40 -repeat 80


run 80;
