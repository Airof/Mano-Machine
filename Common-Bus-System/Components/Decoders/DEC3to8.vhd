library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity DEC3to8 is
    port (
        W: in std_logic_vector(2 downto 0);
        Y: out std_logic_vector(7 downto 0);
        enable: in std_logic
    );
end entity DEC3to8;