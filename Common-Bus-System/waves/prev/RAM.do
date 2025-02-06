vcom RAM/DEC12to4096.vhd
vcom RAM/DEC2to4.vhd
vcom RAM/DEC4to16.vhd
vcom RAM/RandomAccessMemory.vhd

vsim work.RAM

add wave *
# add wave test
add wave cell_outputs


force memory_enable 1 0
force R_flag 0 0
force addr  12'h8 0 
force input_data 16'h21 0
force R_flag 1 10

run 10