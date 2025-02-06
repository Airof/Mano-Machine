library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

-- 2x4 decoder
entity DEC2to4 is
    port (
        W: in std_logic_vector;
        Y: out std_logic_vector(1 downto 0);
        enable: in std_logic
    );
end entity DEC2to4;




architecture structural of DEC2to4 is
    
begin
    
    Y(0) <= enable and W;
    Y(1) <= enable and (NOT W);
     
    
end architecture structural;

