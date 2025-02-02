library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


--SR(set reset) latch
--latches are used for storing data
--will be used as memory cells  
entity SR is
    port (
        S,R: in std_logic;
        Q: inout std_logic
    );
end entity SR;

architecture behavorial of SR is
    signal notQ: std_logic := '0';
begin

    Q <= R nor notQ;
    notQ <= S nor Q;
    
    
end architecture behavorial;

-- SR Latch can store data
--
-- Truth Table for SR Latch:
-- | S (Set) | R (Reset) | Q (Current State) | Q' (Inverse State) |
-- |---------|-----------|-------------------|---------------------|
-- |    0    |     0     |         0         |          1          | (Initial state)
-- |    0    |     1     |         0         |          1          | (Reset state)
-- |    1    |     0     |         1         |          0          | (Set state)
-- |    1    |     1     |   Invalid State   |   Invalid State     | (undefined, not allowed)