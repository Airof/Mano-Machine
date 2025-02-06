vcom RAM/Set-reset-latch.vhd
vcom RAM/Binary-Cell.vhd
vcom RAM/Memory-cell.vhd

vsim work.MemoryCell
add wave *

force Memory_enable 1 0
force R_flag 0 0, 1 50 -repeat 100

force input_data 1100110011001100 0, 1111000011110000 80, 0000111111110000 160 -repeat 200

run 1000