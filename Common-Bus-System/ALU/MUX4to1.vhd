library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity MUX4to1 is
    port (
        input : in std_logic_vector(3 downto 0);
        sel : in std_logic_vector(1 downto 0);
        q : out std_logic
    );
end entity MUX4to1;

architecture Behavorial of MUX4to1 is
    
begin

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
    q <= (input(0) and (NOT sel(1)) and (NOT sel(0))) or
         (input(1) and (NOT sel(1)) and sel(0)) or
         (input(2) and sel(1) and (NOT sel(0))) or
         (input(3) and sel(1) and sel(0));
    
end architecture Behavorial;