library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity Bus7 is
    port (
        inp1,inp2,inp3,inp4,inp5,inp6,inp7:
             in std_logic_vector(15 downto 0);
        sel: in std_logic_vector(2 downto 0);
        on_BUS: out std_logic_vector(15 downto 0)
    );
end entity Bus7;


architecture structural of Bus7 is
    
    component MUX8to1 is
        port (
            input: in std_logic_vector(7 downto 0);
            sel: in std_logic_vector(2 downto 0);
            q: out std_logic
        );
    end component MUX8to1;

begin
    
    BUS_GEN : for i in 0 to 15 generate
        signal BUS_BIT: std_logic_vector(7 downto 0);
    begin
        BUS_BIT <= inp7(i) & inp6(i) & inp5(i) & inp4(i) &
                    inp3(i) & inp2(i) & inp1(i) & '0';

        BIT_sel: entity work.MUX8to1
            port map (
                input => BUS_BIT,
                sel => sel,
                q => on_BUS(i)
            );
    end generate;
    
end architecture structural;