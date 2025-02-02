library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- logical calculator
-- can calculate proimary logic operation for a single Bit
-- supported op => AND OR XOR NOT 
entity logicX1 is
    port (
        S: in std_logic_vector(1 downto 0);
        A, B: in std_logic;
        ei: out std_logic  
    );
end entity logicX1;

architecture Behavorial of LogicX1 is

-- component used => MUX4to1 for selecting operatins
-- signals used => opr for sending the operation values to selector

    component MUX4to1 is
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;

    signal opr: std_logic_vector(3 downto 0);
    
begin

    
    -- calculating the operations
    opr(0) <= A and B;
    opr(1) <= A or B;
    opr(2) <= A xor B;
    opr(3) <= NOT A;

    -- selecting the operations
    operation_detect: MUX4to1 port map(
        Sel => S,
        input => opr,
        q => ei
    );
    
end architecture Behavorial;




-- logicX1: 1-bit logical operation unit using a 4-to-1 multiplexer.
--
--
-- Operation:
--   - The signals `opr` store the possible operations:
--     opr(0) = A AND B
--     opr(1) = A OR B
--     opr(2) = A XOR B
--     opr(3) = NOT A
--
--   - A MUX4to1 selects one of these operations based on `S`.

-- Truth Table:
--   S1 S0 | Operation  | Output (ei)
--  -------------------------------
--    0  0 | A AND B   | A AND B
--    0  1 | A OR B    | A OR B
--    1  0 | A XOR B   | A XOR B
--    1  1 | NOT A     | NOT A
--
--   Each logicX1 unit performs this operation on a single bit.
--   When used in the LOGIC entity, 16 instances operate bitwise on vectors.

