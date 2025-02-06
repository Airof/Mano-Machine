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

architecture structural of DEC3to8 is
    

begin
    
    
    
end architecture structural;


-- Truth Table for 3-to-8 Decoder:
-- | A | B | C | Y(7) | Y(6) | Y(5) | Y(4) | Y(3) | Y(2) | Y(1) | Y(0) |
-- |---|---|---|------|------|------|------|------|------|------|------|
-- | 0 | 0 | 0 |   1  |   0  |   0  |   0  |   0  |   0  |   0  |   0  |
-- | 0 | 0 | 1 |   0  |   1  |   0  |   0  |   0  |   0  |   0  |   0  |
-- | 0 | 1 | 0 |   0  |   0  |   1  |   0  |   0  |   0  |   0  |   0  |
-- | 0 | 1 | 1 |   0  |   0  |   0  |   1  |   0  |   0  |   0  |   0  |
-- | 1 | 0 | 0 |   0  |   0  |   0  |   0  |   1  |   0  |   0  |   0  |
-- | 1 | 0 | 1 |   0  |   0  |   0  |   0  |   0  |   1  |   0  |   0  |
-- | 1 | 1 | 0 |   0  |   0  |   0  |   0  |   0  |   0  |   1  |   0  |
-- | 1 | 1 | 1 |   0  |   0  |   0  |   0  |   0  |   0  |   0  |   1  |
