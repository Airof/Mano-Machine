library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- MemoryCell: A 16-bit memory cell using BC latches to store data.
entity MemoryCell is
    port (
        memory_enable, R_flag: in std_logic;
        input_data: in std_logic_vector(15 downto 0);
        output_data: out std_logic_vector(15 downto 0)
    );
end entity MemoryCell;

architecture structural of MemoryCell is
    component BC is
        port (
            cell_input, R, sel: in std_logic;
            Cell_output: out std_logic
        );
    end component BC;

begin
    
    -- using for generate to connect 16 port maps of the Binary cell
    MemoryCell_GEN: for i in 15 downto 0 generate
        cell: BC port map (
            cell_input => input_data(i),
            R => R_flag,
            sel => memory_enable,
            Cell_output => output_data(i)
        );
    end generate;
    
end architecture structural;


