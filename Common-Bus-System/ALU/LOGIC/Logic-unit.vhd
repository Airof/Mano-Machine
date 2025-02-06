library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

-- logical calculator for 16 Bits
-- supported op => AND OR XOR NOT 
entity LOGIC is
    port (
        Sel: in std_logic_vector(1 downto 0);
        A, B: in std_logic_vector(15 downto 0);
        E: out std_logic_vector(15 downto 0)
    );
end entity LOGIC;

architecture structural of LOGIC is

-- used components => logicX1 for calculations of each Bit

    component logicX1 is
        port (
            S: in std_logic_vector(1 downto 0);
            A, B: in std_logic;
            ei: out std_logic  
        );
    end component logicX1;

begin


    -- generator for mapping X16 single-Bit logic units 
    LOGIC_UNIT_GEN: for i in 0 to 15 generate
        logic: logicX1 port map(
            S => Sel,
            A => A(i),
            B => B(i),
            ei => E(i)
        );
    end generate;
    
    
    
end architecture structural;

-- LOGIC: 16-bit logical operation unit using 1-bit logic elements.
--
--
-- Operation:
--   - Uses 16 instances of `logicX1`, each handling one bit.
--   - Each `logicX1` unit performs a logical operation on a corresponding bit of A and B.
--   - The operation is selected using the `Sel` signal.

-- Truth Table (for each bit pair A(i), B(i)):
--   S1 S0 | Operation  | Output E(i)
--  ---------------------------------
--    0  0 | A AND B   | A(i) AND B(i)
--    0  1 | A OR B    | A(i) OR B(i)
--    1  0 | A XOR B   | A(i) XOR B(i)
--    1  1 | NOT A     | NOT A(i)
--
--   The result is computed bitwise for all 16 bits.
