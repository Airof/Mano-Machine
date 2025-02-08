library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity enc8to3 is
    port (
        input: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(2 downto 0)
    );
end entity enc8to3;

architecture structural of enc8to3 is
    
begin
    
    output(0) <= input(7)  OR input(5)  OR input(3)  OR input(1);
    output(1) <= input(7)  OR input(6)  OR input(3)  OR input(2);
    output(2) <= input(7)  OR input(6)  OR input(5)  OR input(4);

end architecture structural;