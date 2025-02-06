vcom register/core/jk_FlipFlop.vhd
vcom register/Timing/4bit-seq-counter.vhd

vsim work.seq_counter
add wave *


force clear 0
force clk 0 0ns, 1 5ns -repeat 10ns 

force increament 0

run 10ns

force increament 1 
run 100ns

force clear 1
run 10ns








    # port (
    #   increament: in std_logic;
    #   clear: in std_logic;
    #   clk: std_logic;
    #   c_out: out std_logic
    # );