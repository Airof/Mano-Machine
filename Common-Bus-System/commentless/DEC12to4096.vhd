library IEEE;
use IEEE.std_logic_1164.all;
entity DEC12to4096 is
    port (
        addr: in std_logic_vector(11 downto 0);
        Cell_selector: out std_logic_vector(4095 downto 0);
        enable: in std_logic
    );
end entity DEC12to4096;
architecture structural of DEC12to4096 is
    component DEC4to16 is
        port (
            W: in std_logic_vector(3 downto 0);
            Y: out std_logic_vector(15 downto 0);
            enable: in std_logic
        );
    end component;
    signal level1_enables : std_logic_vector(15 downto 0); 
    signal level2_enables : std_logic_vector(255 downto 0); 
begin
    U1_Level1: DEC4to16
    port map (
        W      => addr(11 downto 8),
        Y      => level1_enables,
        enable => enable
    );
    GEN_Level2: for i in 0 to 15 generate
    U2_Level2: DEC4to16
        port map (
            W      => addr(7 downto 4),
            Y      => level2_enables(i*16 + 15 downto i*16),
            enable => level1_enables(i)
        );
    end generate GEN_Level2;
    GEN_Level3: for j in 0 to 255 generate
    U3_Level3: DEC4to16
        port map (
            W      => addr(3 downto 0),
            Y      => Cell_selector(j*16 + 15 downto j*16),
            enable => level2_enables(j)
        );
    end generate GEN_Level3;
end architecture structural;
