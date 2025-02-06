library IEEE;
use IEEE.std_logic_1164.all;
entity LOGIC is
    port (
        Sel: in std_logic_vector(1 downto 0);
        A, B: in std_logic_vector(15 downto 0);
        E: out std_logic_vector(15 downto 0)
    );
end entity LOGIC;
architecture structural of LOGIC is
    component logicX1 is
        port (
            S: in std_logic_vector(1 downto 0);
            A, B: in std_logic;
            ei: out std_logic  
        );
    end component logicX1;
begin
    LOGIC_UNIT_GEN: for i in 0 to 15 generate
        logic: logicX1 port map(
            S => Sel,
            A => A(i),
            B => B(i),
            ei => E(i)
        );
    end generate;
end architecture structural;
