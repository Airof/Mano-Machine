vcom RAM/Set-reset-latch.vhd
vsim work.SR
add wave *


force S 0 0, 1 10 -repeat 20
force R 1 0, 0 10 -repeat 40
run 50;


