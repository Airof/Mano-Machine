library IEEE;
use IEEE.std_logic_1164.all;
entity RAM is
    port(
        addr : in std_logic_vector(11 downto 0);
        input_data : in std_logic_vector(15 downto 0);
        output_data : out std_logic_vector(15 downto 0);
        memory_enable : in std_logic;
        R_flag : in std_logic
    );
end entity RAM;
architecture structural of RAM is
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
    component OR_4096 is
        port (
            input: in std_logic_vector(4095 downto 0);
            output: out std_logic
        );
    end component;
    type ram_array is array (0 to 4095) of std_logic_vector(15 downto 0); 
    signal cell_select: std_logic_vector(4095 downto 0);
    signal cell_outputs: ram_array := (others => (others => '0'));
    signal selected_bits: std_logic_vector(4095 downto 0);
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
                output_data => cell_outputs(i)
            );
    end generate;
    OUTPUT_GEN : for i in 0 to 15 generate
    begin
        selected_bits <= (others => '0');
        GEN_BITS : for j in 0 to 4095 generate
            selected_bits(j) <= cell_outputs(j)(i);  
        end generate;
        and_out: OR_4096 port map (
            input => selected_bits,
            output => output_data(i)
        );
    end generate;
end architecture structural;
