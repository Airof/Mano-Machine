vcom RAM/Set-reset-latch.vhd
vcom RAM/Binary-Cell.vhd
vsim work.BC
add wave *

force cell_input 0 0, 1 5 -repeat 10
force R 0 0, 1 10 -repeat 20
force sel 0 0, 1 20 -repeat 40

run 80;

