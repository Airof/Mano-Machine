library IEEE;
use IEEE.std_logic_1164.all;
entity ShiftLR is
    port (
        Shift_dir: in std_logic; 
        A: in std_logic_vector(15 downto 0);
        H: out std_logic_vector(15 downto 0)
    );
end entity ShiftLR;
architecture structural of ShiftLR is
    component MUX2to1 is
         port (
            input : in std_logic_vector(1 downto 0);
            sel : in std_logic;
            q : out std_logic
        );
    end component;
    signal mux_input: std_logic_vector(17 downto 0);
begin 
    mux_input(0) <= '0';
    mux_input(17) <= '0';
    mux_input(16 downto 1) <= A(15 downto 0);
    SHIFT_GEN : for i in 0 to 15 generate
        bit_shift: MUX2to1 port map(
            input(0) => mux_input(i),
            input(1) => mux_input(i+2),
            sel => Shift_dir,
            q => H(i) 
        );
    end generate;
end architecture;
