library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity seq_counter is
    generic(
        size: integer := 4
    );
    port (
      increment: in std_logic;
      clear: in std_logic;
      clk: std_logic;
      A_out: out std_logic_vector(size-1 downto 0);
    --   A_out: out std_logic_vector(3 downto 0);
      c_out: out std_logic -- use if needed carry
    );
end entity seq_counter;

architecture structural of seq_counter is

    --the design is on ALU directory
    component JKff is 
        port(
            J,K,CLK,Clear : in std_logic;
            y : out std_logic
        );
    end component;
    
    
    signal toggle_sig: std_logic_vector(size downto 0);
    signal out_sig: std_logic_vector(size-1 downto 0);
begin
    


    toggle_sig(0) <= increment;
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

    A_out <= out_sig; 
    c_out <= toggle_sig(size); -- use if needed carry
    
end architecture structural;