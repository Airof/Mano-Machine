vcom register/core/jk_FlipFlop.vhd
vcom register/core/register.vhd

vsim reg
add wave *

force data_in 0110
force clear 0
force load 0
force count 0
force clk 0 0ns, 1 0.5ns -repeat 1ns
run 1ns

force load 1
run 1ns

force load 0
force clear 1 
run 1ns 

force clear 0
force load 1
run 1ns

force load 0 
run 1ns




run 10
    # port(
    #     Count,load : in std_logic;
    #     Data_in : in std_logic_vector(3 downto 0);
    #     Clk,Clear : in std_logic;
    #     A_count : out std_logic_vector(3 downto 0);
    #     C_out : out std_logic
    # );