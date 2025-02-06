vcom ALU/MUX2to1.vhd
vcom ALU/Shift-register.vhd
vsim work.ShiftLR
add wave *  

force A 1111111111111111 0, 1111000000001111 2, 0000111100001111 4 -repeat 6
force Shift_dir 0 0, 1 1 -repeat 2

run 10