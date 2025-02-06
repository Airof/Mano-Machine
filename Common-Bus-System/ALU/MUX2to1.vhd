library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- select one out of two bits
entity MUX2to1 is
    port (
        input : in std_logic_vector(1 downto 0);
        sel : in std_logic;
        q : out std_logic
    );
end entity MUX2to1;

architecture structural of MUX2to1 is
    
begin

    q <= (input(0) and (NOT sel)) or (input(1) and sel);
    
end architecture structural;

-- MUX2to1 is a multiplexer that selects one of the two input signals
-- based on the value of the selector 'sel'.
--
-- Truth Table:
-- sel | q
--  0  | input(0)
--  1  | input(1)