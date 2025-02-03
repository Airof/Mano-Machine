library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity JKff is 
    port(
        J,K,CLK,Clear : in std_logic;
        y : out std_logic
    );
end entity;

architecture behavioral of JKff is
    signal q, q_next : std_logic := '0';
begin
    q_next <= (not q) when (J = '1' and K = '1') else
              '1' when (J = '1' and K = '0') else
              '0' when (J = '0' and K = '1') else
              q;
              
    q <= '0' when Clear = '1' else q_next when rising_edge(CLK);
    y <= q;

end architecture;



    -- | J | K | Clear | CLK (↑)| q (قبلی) | q_next | y (خروجی)|
    -- |---|---|-------|--------|----------|--------|-----------|
    -- | 0 | 0 | 0     | ↑      | 0        | 0      | 0         |
    -- | 0 | 0 | 0     | ↑      | 1        | 1      | 1         |
    -- | 0 | 1 | 0     | ↑      | 0        | 0      | 0         |
    -- | 0 | 1 | 0     | ↑      | 1        | 0      | 0         |
    -- | 1 | 0 | 0     | ↑      | 0        | 1      | 1         |
    -- | 1 | 0 | 0     | ↑      | 1        | 1      | 1         |
    -- | 1 | 1 | 0     | ↑      | 0        | 1      | 1         |
    -- | 1 | 1 | 0     | ↑      | 1        | 0      | 0         |
    -- | X | X | 1     | X      | X        | 0      | 0         | 
