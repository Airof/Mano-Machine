vcom RAM/Set-reset-latch.vhd
vsim work.SR
add wave *


force S 0 0, 1 10, 0 20;
force R 0 0, 1 15, 0 25;
run 50;
