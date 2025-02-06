library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

-- 2x4 decoder
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



-- Truth Table for 1-to-2 Decoder:
-- | Input (A) | Output (Y0) | Output (Y1) |
-- |-----------|-------------|-------------|
-- |     0     |      1      |      0      |
-- |     1     |      0      |      1      |

