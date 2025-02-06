library IEEE;
use IEEE.std_logic_1164.all;
entity logicX1 is
    port (
        S: in std_logic_vector(1 downto 0);
        A, B: in std_logic;
        ei: out std_logic  
    );
end entity logicX1;
architecture structural of LogicX1 is
    component MUX4to1 is
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;
    signal opr: std_logic_vector(3 downto 0);
begin
    opr(0) <= A and B;
    opr(1) <= A or B;
    opr(2) <= A xor B;
    opr(3) <= NOT A;
    operation_detect: MUX4to1 port map(
        Sel => S,
        input => opr,
        q => ei
    );
end architecture structural;
