library IEEE;
use IEEE.std_logic_1164.all;
entity reg is
    port(
        Count,load : in std_logic;
        Data_in : in std_logic_vector(3 downto 0);
        Clk,Clear : in std_logic;
        A_count : out std_logic_vector(3 downto 0);
        C_out : out std_logic
    );
end entity;
architecture structural of reg is 
    component JKff is 
        port(
            J,K,CLK,Clear : in std_logic;
            y : out std_logic
        );
    end component;
        signal J_signals, K_signals : std_logic_vector(3 downto 0);
        signal A_signals : std_logic_vector(3 downto 0);
        signal and_load_data, and_count_a : std_logic_vector(3 downto 0);
        signal and_clear_a : std_logic;
begin
    and_load_data(0) <= Load and Data_in(0);
    and_load_data(1) <= Load and Data_in(1);
    and_load_data(2) <= Load and Data_in(2);
    and_load_data(3) <= Load and Data_in(3);
    and_count_a(0) <= Count and A_signals(0);
    and_count_a(1) <= Count and A_signals(1);
    and_count_a(2) <= Count and A_signals(2);
    and_count_a(3) <= Count and A_signals(3);
    J_signals(0) <= and_load_data(0) or and_count_a(0);
    K_signals(0) <= not and_count_a(0);
    J_signals(1) <= and_load_data(1) or and_count_a(1);
    K_signals(1) <= not and_count_a(1);
    J_signals(2) <= and_load_data(2) or and_count_a(2);
    K_signals(2) <= not and_count_a(2);
    J_signals(3) <= and_load_data(3) or and_count_a(3);
    K_signals(3) <= not and_count_a(3);
    U0: JKff port map (J_signals(0), K_signals(0), Clk, Clear, A_signals(0));
    U1: JKff port map (J_signals(1), K_signals(1), Clk, Clear, A_signals(1));
    U2: JKff port map (J_signals(2), K_signals(2), Clk, Clear, A_signals(2));
    U3: JKff port map (J_signals(3), K_signals(3), Clk, Clear, A_signals(3));
    A_count <= A_signals;
    C_out <= A_signals(3) and Count;
end architecture structural;
