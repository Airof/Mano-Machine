library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- get a 16bit reqister and Left/Right shift it 
-- Shift_dir = '0' => right // shift_dir = '1' => left 
entity ShiftLR is
    port (
        Shift_dir: in std_logic; --0 for right // 1 for left
        A: in std_logic_vector(15 downto 0);
        H: out std_logic_vector(15 downto 0)
    );
end entity ShiftLR;

architecture structural of ShiftLR is

-- used components => MUX2to1
-- used signals => mux_input for padding(line 70) 
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


-- ShiftLR: 16-bit logical shifter using 2-to-1 multiplexers.
--
-- Ports:
--   Shift_dir : Shift direction control signal.
--               '0' for right shift, '1' for left shift.
--   A         : 16-bit input vector.
--   H         : 16-bit output vector (shifted result).
--
-- Operation:
--   - The input A is extended with two zero-padding bits.
--   - Each bit of H is selected using a 2-to-1 multiplexer.
--   - If Shift_dir = '0', the bit is taken from the previous position (right shift).
--   - If Shift_dir = '1', the bit is taken from the next position (left shift).
--
-- Truth Table (Example for A = "1001100110011001"):
--   Shift_dir | Output (H)
--  --------------------------------
--      0      | 0100110011001100  (Right shift)
--      1      | 0011001100110010  (Left shift)


-- why padding?
-- generate is used  for code simplicity
-- the first and last input of the 16 MUXs used in shiftLR are const '0'
-- in for generate we can't have const and variables at the same time (same as other languages)
-- for eaxample in python:
--      for i in range(10): print value(i)
-- value(i) can't set to a const in for and this has to be done before the fore
-- vhdl is static language so the size of the ports cant change  
-- so the solution is to define a variable(signal) with length of 18(16+2) to store values Il-A-Ir in itself temporerly