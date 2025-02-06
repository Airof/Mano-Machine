library IEEE;
use IEEE.std_logic_1164.all;
entity RAM_tb is
end entity RAM_tb;
architecture sim of RAM_tb is
    signal addr : std_logic_vector(11 downto 0);
    signal input_data : std_logic_vector(15 downto 0);
    signal output_data : std_logic_vector(15 downto 0);
    signal memory_enable : std_logic := '0';
    signal R_flag : std_logic := '0';
begin
    uut: entity work.RAM
        port map (
            addr => addr,
            input_data => input_data,
            output_data => output_data,
            memory_enable => memory_enable,
            R_flag => R_flag
        );
    stimulus: process
    begin
        addr <= "000000000000"; 
        input_data <= "0000000000000001"; 
        memory_enable <= '1'; 
        R_flag <= '1'; 
        wait for 100 ns;
        addr <= "000000000001"; 
        input_data <= "0000000000000010"; 
        wait for 100 ns;
        assert false report "Simulation finished" severity failure;
    end process;
end architecture sim;
