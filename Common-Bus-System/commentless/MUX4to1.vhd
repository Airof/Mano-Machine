library IEEE;
use IEEE.std_logic_1164.all;
entity MUX4to1 is
    port (
        input : in std_logic_vector(3 downto 0);
        sel : in std_logic_vector(1 downto 0);
        q : out std_logic
    );
end entity MUX4to1;
architecture structural of MUX4to1 is
begin
    q <= (input(0) and (NOT sel(1)) and (NOT sel(0))) or
         (input(1) and (NOT sel(1)) and sel(0)) or
         (input(2) and sel(1) and (NOT sel(0))) or
         (input(3) and sel(1) and sel(0));
end architecture structural;
