library IEEE;
use IEEE.std_logic_1164.all;
entity seq_counter is
    generic(
        size: integer := 4
    );
    port (
      increament: in std_logic;
      clear: in std_logic;
      clk: std_logic;
      c_out: out std_logic
    );
end entity seq_counter;
architecture structural of seq_counter is
    component JKff is 
        port(
            J,K,CLK,Clear : in std_logic;
            y : out std_logic
        );
    end component;
    signal toggle_sig: std_logic_vector(size downto 0);
    signal out_sig: std_logic_vector(size-1 downto 0);
begin
    toggle_sig(0) <= increament;
    toggle_GEN : for i in 1 to size generate
        toggle_sig(i) <= out_sig(i-1) and toggle_sig(i-1);
    end generate;
    Counter_GEN : for i in 0 to size-1 generate
        Count_I: jkff port map (
            J => toggle_sig(i),
            k => toggle_sig(i),
            clk => clk,
            clear => clear,
            y => out_sig(i)
        );
    end generate;
    c_out <= toggle_sig(size);
end architecture structural;
