library IEEE;
use IEEE.std_logic_1164.all;

entity RAM_tb is
end entity RAM_tb;

architecture sim of RAM_tb is

    -- Testbench signals
    signal addr : std_logic_vector(11 downto 0);
    signal input_data : std_logic_vector(15 downto 0);
    signal output_data : std_logic_vector(15 downto 0);
    signal memory_enable : std_logic := '0';
    signal R_flag : std_logic := '0';

begin

    -- Instantiate the RAM module
    uut: entity work.RAM
        port map (
            addr => addr,
            input_data => input_data,
            output_data => output_data,
            memory_enable => memory_enable,
            R_flag => R_flag
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Test scenario 1
        addr <= "000000000000"; -- Set address to 0
        input_data <= "0000000000000001"; -- Set input data
        memory_enable <= '1'; -- Enable memory
        R_flag <= '1'; -- Read flag
        
        wait for 100 ns;
        
        -- Test scenario 2
        addr <= "000000000001"; -- Set address to 1
        input_data <= "0000000000000010"; -- Set new input data
        
        wait for 100 ns;
        
        -- Finish simulation
        assert false report "Simulation finished" severity failure;
    end process;

end architecture sim;
