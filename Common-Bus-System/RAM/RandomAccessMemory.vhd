library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


entity RandomAccessMemory is 
    port(
        addr : in std_logic_vector(11 downto 0);
        input_data : in std_logic_vector(15 downto 0);
        output_data : out std_logic_vector(15 downto 0);
        memory_enable : in std_logic;
        R_flag : in std_logic
    );
end entity RandomAccessMemory;

architecture structural of RandomAccessMemory is

    component DEC12to4096 is
        port (
            addr: in std_logic_vector(11 downto 0);
            Cell_selector: out std_logic_vector(4095 downto 0);
            enable: in std_logic
        );
    end component;

    component MemoryCell is
        port (
            memory_enable, R_flag: in std_logic;
            input_data: in std_logic_vector(15 downto 0);
            output_data: out std_logic_vector(15 downto 0)
        );
    end component;

    signal cell_select: std_logic_vector(4095 downto 0);
    signal cell_outputs: std_logic_vector(65535 downto 0); -- 4096 * 16

begin

    decoder: DEC12to4096
        port map (
            addr => addr,
            Cell_selector => cell_select,
            enable => memory_enable
        );

    gen_cells: for i in 0 to 4095 generate
        cell: MemoryCell
            port map (
                memory_enable => cell_select(i),
                R_flag => R_flag,
                input_data => input_data,
                output_data => cell_outputs((i+1)*16-1 downto i*16)
            );
    end generate;

    output_mux: process(cell_select, cell_outputs)
    begin
        output_data <= (others => '0');
        for i in 0 to 4095 loop
            if cell_select(i) = '1' then
                output_data <= cell_outputs((i+1)*16-1 downto i*16);
            end if;
        end loop;
    end process;

end architecture structural;
