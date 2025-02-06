library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

-- 2x4 decoder
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


-- 2-to-4 Decoder Truth Table:
--  Enable | W1 W0 | Y3 Y2 Y1 Y0
-- --------------------------------
--     0   |  X  X | 0  0  0  0  (Disabled)
--     1   |  0  0 | 0  0  0  1  
--     1   |  0  1 | 0  0  1  0  
--     1   |  1  0 | 0  1  0  0  
--     1   |  1  1 | 1  0  0  0  

-- Notes:
-- - The decoder is only active when 'enable' is 1.
-- - If 'enable' is 0, all outputs are 0.