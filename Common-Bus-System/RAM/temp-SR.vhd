-- the file below is still not logic based

library IEEE;
use IEEE.std_logic_1164.all;

entity SR is
    port (
        S, R : in  std_logic;
        Q    : out std_logic
    );
end entity SR;

architecture Behave of SR is
    signal internal_Q : std_logic := '0';  -- Initialized state
begin
    -- Explicit type conversion for concatenation
    with std_logic_vector'(S & R) select
        internal_Q <=
            '1'       when "10",  -- Set
            '0'       when "01",  -- Reset
            internal_Q when "00", -- Hold
            'X'       when others;-- Invalid (11)

    Q <= internal_Q;
end architecture Behave;