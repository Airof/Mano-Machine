library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- select one bit out of four
entity MUX4to1 is
    port (
        input : in std_logic_vector(3 downto 0);
        sel : in std_logic_vector(1 downto 0);
        q : out std_logic
    );
end entity MUX4to1;

architecture structural of MUX4to1 is
    

    -- using logical getes
begin
    q <= (input(0) and (NOT sel(1)) and (NOT sel(0))) or
         (input(1) and (NOT sel(1)) and sel(0)) or
         (input(2) and sel(1) and (NOT sel(0))) or
         (input(3) and sel(1) and sel(0));


    -- -- using when else
    -- q <= input(0) when sel = "00" else
    --      input(1) when sel = "01" else
    --      input(2) when sel = "10" else
    --      input(3) when sel = "11";
        
    -- -- using with select
    -- with sel select
    --     q <= input(0) when "00",
    --          input(1) when "01",
    --          input(2) when "10",
    --          input(3) when "11";

    -- using logic design
    
end architecture structural;


-- MUX2to1 is a multiplexer that selects one of the two input signals
-- based on the value of the selector 'sel'.

-- truth table
-- sel   | q
-- "00"  | input(0)
-- "01"  | input(1)
-- "10"  | input(2)
-- "11"  | input(3)