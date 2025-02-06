library IEEE;
use IEEE.std_logic_1164.all;
entity FullAdder is
    port (
        cin, A, B : in std_logic;
        cout, S : out std_logic 
    );
end entity FullAdder;
architecture structural of FullAdder is
begin
    S <= A xor B xor cin;
    cout <= ((A xor B) and cin) or (A and B);
end architecture structural;
