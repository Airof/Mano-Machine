library IEEE;
use IEEE.std_logic_1164.all;
entity OR_16 is
    port (
        input: in std_logic_vector(15 downto 0);
        output: out std_logic
    );
end entity OR_16;
architecture structural of OR_16 is
begin
    output <= input(0) or input(1) or input(2) or input(3) or
              input(4) or input(5) or input(6) or input(7) or
              input(8) or input(9) or input(10) or input(11) or
              input(12) or input(13) or input(14) or input(15);
end architecture structural;
