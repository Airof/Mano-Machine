library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity MUX8to1 is
    port (
        input: in std_logic_vector(7 downto 0);
        sel: in std_logic_vector(2 downto 0);
        q: out std_logic
    );
end entity MUX8to1;


architecture structural of MUX8to1 is

    --its on the "ALU" folder
    component MUX4to1 is 
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;

    component MUX2to1 is
        port (
            input : in std_logic_vector(1 downto 0);
            sel : in std_logic;
            q : out std_logic
        );
    end component MUX2to1;
    
    signal mid: std_logic_vector(1 downto 0);

begin

    
    Up_mux: MUX4to1 port map (
        input => input(7 downto 4),
        sel => sel(1 downto 0),
        q => mid(1)
    );
    
    Down_mux: MUX4to1 port map (
        input => input(3 downto 0),
        sel => sel(1 downto 0),
        q => mid(0)
    );
    
    mux_sel: MUX2to1 port map (
        input => mid,
        sel => sel(2),
        q => q
    );
    
end architecture structural;