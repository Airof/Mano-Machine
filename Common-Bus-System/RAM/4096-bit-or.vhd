library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


entity OR_4096 is
    port (
        input: in std_logic_vector(4095 downto 0);
        output: out std_logic
    );
end entity OR_4096;



architecture structural of OR_4096 is
    
    component OR_16 is
        port (
            input: in std_logic_vector(15 downto 0);
            output: out std_logic
        );
    end component;

    signal intermediate1: std_logic_vector(255 downto 0);
    signal intermediate2: std_logic_vector(15 downto 0);

begin
    
    OR_GEN_l1: for i in 0 to 255 generate
        OR_port: OR_16 port map(
            input => input(i*16+15 downto 16*i),
            output => intermediate1(i)
        );
    end generate;

    OR_GEN_l2: for i in 0 to 15 generate
        OR_port: OR_16 port map(
            input => input(i*16+15 downto 16*i),
            output => intermediate2(i)
        );
    end generate;

    OR_GEN_l3: OR_16 port map (
        input => intermediate2,
        output => output
    );
    
end architecture structural;