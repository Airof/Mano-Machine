library IEEE;
use IEEE.std_logic_1164.all;
entity DEC1to2 is
    port (
        W: in std_logic;
        enable: in std_logic;
        Y: out std_logic_vector(1 downto 0)
    );
end entity DEC1to2;
architecture structural of DEC1to2 is
begin
    Y(1) <= enable and W;
    Y(0) <= enable and (NOT W);
end architecture structural;
