library IEEE;
use IEEE.std_logic_1164.all;
entity BC is
    port (
        cell_input, R, sel: in std_logic;
        Cell_output: out std_logic
    );
end entity BC;
architecture structural of BC is
    component SR is 
    port (
        S,R: in std_logic;
        Q: inout std_logic
    );
    end component;
    signal SR_out: std_logic;
    signal S_sig, R_sig: std_logic;
begin
    SRlatch: SR port map (S_sig, R_sig, SR_out);
    S_sig <= Sel and cell_input and (not R);
    R_sig <= sel and (not cell_input) and (not R);
    Cell_output <= Sel and R and SR_out;
end architecture structural;
