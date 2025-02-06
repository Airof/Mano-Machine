library IEEE;
use IEEE.std_logic_1164.all;
entity ALU is
    port (
        S : in std_logic_vector(3 downto 0);
        cin: std_logic;
        A, B: in std_logic_vector(15 downto 0);
        F: out std_logic_vector(15 downto 0);
        E: out std_logic
    );
end entity ALU;
architecture structural of ALU is
    component Arithmetic is
        port (
            A, B: in std_logic_vector(15 downto 0);
            sel: in std_logic_vector(1 downto 0);
            cin: in std_logic;
            cout: out std_logic;
            D: out std_logic_vector(15 downto 0)
            );
        end component Arithmetic;
    component LOGIC is
        port (
            Sel: in std_logic_vector(1 downto 0);
            A, B: in std_logic_vector(15 downto 0);
            E: out std_logic_vector(15 downto 0)
        );
    end component LOGIC;
    component ShiftLR is
        port (
            Shift_dir: in std_logic;
            A: in std_logic_vector(15 downto 0);
            H: out std_logic_vector(15 downto 0)
        );
    end component ShiftLR;
    component MUX4to1 is
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;
    signal Arith_val: std_logic_vector(15 downto 0);
    signal logic_val: std_logic_vector(15 downto 0);
    signal shift_val_L: std_logic_vector(15 downto 0);
    signal shift_val_R: std_logic_vector(15 downto 0);
begin
    Arithmetic_block: Arithmetic port map(
        A => A,
        B => B,
        sel => S(1 downto 0),
        cin => cin,
        cout => E,
        D => Arith_val
    );
    Logic_block: LOGIC port map(
        Sel => S(1 downto 0),
        A => A,
        B=> B,
        E=> logic_val
    );
    Shift_Right_block: ShiftLR port map(
        Shift_dir => '0',
        A => A,
        H => shift_val_R
    );
    Shift_Left_block: ShiftLR port map(
        Shift_dir => '1',
        A => A,
        H => shift_val_L
    );
    FINAL_VALUE_GEN: for i in 0 to 15 generate  
        Final_value: MUX4to1 port map(
            input(0) => Arith_val(i),
            input(1) => logic_val(i),
            input(2) => shift_val_R(i),
            input(3) => shift_val_L(i),
            sel => S(3 downto 2),
            q => F(i)
        );
    end generate;
end architecture structural;
