library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- a normal calculator
-- can calculate add sub 

entity Arithmetic is
    port (
        A, B: in std_logic_vector(15 downto 0);
        sel: in std_logic_vector(1 downto 0);
        cin: in std_logic;

        cout: out std_logic;
        D: out std_logic_vector(15 downto 0)
    );
end entity Arithmetic;


architecture structural of Arithmetic is

-- Components:
--   - FullAdder:  A 1-bit full adder used to build a 16-bit adder.
--   - MUX4to1:    A 4-to-1 multiplexer selects the B input modification.
-- Signals: NOTB // mux_output // carry

    component FullAdder is
        port (
            cin, A, B : in std_logic;
            cout, S : out std_logic 
        );
    end component;

    component MUX4to1 is
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;

    
    signal NOTB: std_logic_vector(15 downto 0);
    signal mux_output: std_logic_vector(15 downto 0);
    signal carry: std_logic_vector(16 downto 0);
begin
    

    NOTB <= NOT B;
    carry(0) <= cin;
    cout <= carry(16);

    GEN_MUX: for i in 0 to 15 generate
        MUX: MUX4to1 port map(
            input(0) => B(i),
            input(1) => NOTB(i),
            input(2) => '0',
            input(3) => '1',
            sel => sel,
            q => mux_output(i)
        );
    end generate;


    GEN_FA: for i in 0 to 15 generate
    FA: FullAdder port map(
        cin => carry(i),
        A => A(i),
        B => mux_output(i),
        cout => carry(i+1),
        S => D(i)
    );
    end generate;



end architecture structural;



-- ==================================================
-- 16-bit Arithmetic Unit Summary:
-- ==================================================
-- - This module performs arithmetic operations on 16-bit inputs A and B.
-- - The operation is determined by the 2-bit select input (sel) and carry-in (cin).
-- - Outputs the result (D) and carry-out (cout).
--
-- ==================================================
-- Operation Table:
-- ==================================================
-- | sel  | cin | Operation         | Performed Calculation  |
-- |------|-----|-------------------|------------------------|
-- | "00" |  0  | Add               | D = A + B             |
-- | "00" |  1  | Add with carry    | D = A + B + 1         |
-- | "01" |  0  | Subtract w/borrow | D = A + NOT(B)        |
-- | "01" |  1  | Subtract          | D = A + NOT(B) + 1    |
-- | "10" |  0  | Transfer A        | D = A                 |
-- | "10" |  1  | Increment A       | D = A + 1             |
-- | "11" |  0  | Decrement A       | D = A - 1             |
-- | "11" |  1  | Transfer A        | D = A                 |
--
-- ==================================================
-- Implementation Details:
-- ==================================================
-- - A 4-to-1 multiplexer selects between B, NOT B, '0', or '1'.
-- - A 16-bit ripple carry adder performs addition or subtraction.
-- - Carry propagation is handled through chained FullAdder components.
-- - The module is designed for use in larger ALUs or CPUs.
