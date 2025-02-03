library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- one bit memory cell(SR latch)
-- its used for storing data and has two options
--R='1' => Reading from the input // R='0' writing to the output
entity BC is
    port (
        cell_input, R, sel: in std_logic;
        Cell_output: out std_logic
    );
end entity BC;

architecture behavorial of BC is

--used components: SR as an memory cell

    component SR is 
    port (
        S,R: in std_logic;
        Q: inout std_logic
    );
    end component;

    signal SR_out: std_logic;
    signal S_sig, R_sig: std_logic;
begin

    SRlatch: SR port map (S_sig, R_sig, SR_out);

    S_sig <= Sel and cell_input and (not R);
    R_sig <= sel and (not cell_input) and (not R);
    Cell_output <= Sel and R and SR_out;

    
    
    
end architecture behavorial;


--                    block diagram

--                       select
--                         |
--                     ____|____
--      input    ______|        |
--                     |   BC   |_____output   
--                     |________|   
--                         |             
--             Read/Write _|





-- BC: This is a binary cell circuit (BC), used for memory cells in RAM.

-- Truth Table for Binary Cell (SR Latch for RAM):

-- | Read_Write_Flag | Select Flag | S (Set) | R (Reset) | Q (Current State) | Q' (Inverse State) | Cell_output | Action                                  |
-- |-----------------|-------------|---------|-----------|-------------------|---------------------|-------------|-----------------------------------------|
-- |       0         |      0      |    0    |     0     |        Q_prev     |         Q'_prev     |    Q_prev   | Read mode, output current state         |
-- |       0         |      0      |    0    |     1     |        0          |          1          |      0      | Reset state in read mode                |
-- |       1         |      0      |    1    |     0     |        1          |          0          |      1      | Write mode, set state                   |
-- |       1         |      0      |    0    |     1     |        0          |          1          |      0      | Write mode, reset state                 |
-- |       0         |      1      |    0    |     0     |        Q_prev     |         Q'_prev     |    Q_prev   | Read mode with select flag enabled      |
-- |       0         |      1      |    0    |     1     |        0          |          1          |      0      | Reset state with select flag enabled    |
-- |       1         |      1      |    1    |     0     |        1          |          0          |      1      | Write mode with select flag enabled     |
-- |       1         |      1      |    0    |     1     |        0          |          1          |      0      | Write mode, reset state with select flag|

-- Binary Cell Behavior (SR Latch using binary values for RAMs):
-- | Read_Write_Flag | Select Flag | S (Set) | R (Reset) | Q (Current State) | Q' (Inverse State) |
-- |-----------------|-------------|---------|-----------|-------------------|---------------------|
-- |       0         |      0      |    0    |     0     |        0          |         1           | (Initial read state)
-- |       0         |      0      |    0    |     1     |        0          |         1           | (Read reset state)
-- |       1         |      0      |    1    |     0     |        1          |         0           | (Write set state)
-- |       1         |      0      |    0    |     1     |        0          |         1           | (Write reset state)
-- |       0         |      1      |    0    |     0     |        0          |         1           | (Read state with select flag)
-- |       0         |      1      |    0    |     1     |        0          |         1           | (Read reset state with select flag)
-- |       1         |      1      |    1    |     0     |        1          |         0           | (Write set state with select flag)
-- |       1         |      1      |    0    |     1     |        0          |         1           | (Write reset state with select flag)
