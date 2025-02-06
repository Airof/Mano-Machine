library IEEE;
use IEEE.std_logic_1164.all;
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
