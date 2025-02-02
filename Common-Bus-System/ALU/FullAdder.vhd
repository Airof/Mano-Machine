library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

-- FA is used for adding 3 single-Bit values

entity FullAdder is
    port (
        cin, A, B : in std_logic;
        cout, S : out std_logic 
    );
end entity FullAdder;

architecture Behavorial of FullAdder is
    
begin
    
    S <= A xor B xor cin;
    
    cout <= ((A xor B) and cin) or (A and B);
    
    -- Alternate form
    -- Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin); 
    
    
end architecture Behavorial;


-- FullAdder: 1-bit full adder circuit.
--
-- Ports:
--   cin  : Carry input.
--   A, B : Single-bit inputs to be added.
--   S    : Sum output (A XOR B XOR cin).
--   cout : Carry output (generated when at least two inputs are '1').
--
-- Truth Table:
--   A  B  Cin | S  Cout
--  ---------------------
--   0  0   0  | 0    0
--   0  0   1  | 1    0
--   0  1   0  | 1    0
--   0  1   1  | 0    1
--   1  0   0  | 1    0
--   1  0   1  | 0    1
--   1  1   0  | 0    1
--   1  1   1  | 1    1
