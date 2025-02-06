library IEEE;
use IEEE.std_logic_1164.all;
entity DEC2to4 is
    port (
        W: in std_logic_vector(1 downto 0);
        Y: out std_logic_vector(3 downto 0);
        enable: in std_logic
    );
end entity DEC2to4;
architecture structural of DEC2to4 is
begin
    Y(0) <= enable and (not W(1)) and (not W(0));
    Y(1) <= enable and (not W(1)) and W(0);
    Y(2) <= enable and W(1) and (not W(0));
    Y(3) <= enable and W(1) and W(0);
end architecture structural;
