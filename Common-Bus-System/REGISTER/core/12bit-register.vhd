library IEEE;
use IEEE.std_logic_1164.all;

entity reg8 is
    generic(
        size: integer := 12
    );
    port(
        Count, load : in std_logic;
        I : in std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
        Clk, Clear : in std_logic;
        A_out : out std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
        C_out : out std_logic
    );
end entity;



architecture structural of reg8 is 

    component JKff is 
        port(
            J, K, CLK, Clear : in std_logic;
            y : out std_logic
        );
    end component;


    signal count_A_nload: std_logic;
    signal load_A_I: std_logic_vector(size-1 downto 0);
    signal load_A_nI: std_logic_vector(size-1 downto 0);    
    signal prev_AND: std_logic_vector(size downto 0);
    signal J_sig, K_sig: std_logic_vector(size-1 downto 0);
    signal out_sig: std_logic_vector(size-1 downto 0);

begin

    count_A_nload <= count and NOT load;

    LOAD_INPUT_GEN : for j in 0 to size-1 generate
        load_A_I(j) <= load and I(j);
        load_A_nI(j) <= load and NOT I(j);
    end generate;


    prev_AND(0) <= count_A_nload;
    prev_AND_GEN : for j in 1 to size generate
        prev_AND(j) <= out_sig(j-1) and prev_AND(j-1);
    end generate;


    JK_SIG_GEN : for j in 0 to size-1 generate
        J_sig(j) <= Prev_AND(j) or load_A_I(j);
        K_sig(j) <= Prev_AND(j) or load_A_nI(j);
    end generate;

    JK_GEN : for j in 0 to size-1 generate
        UI: JKff port map(
            J => J_sig(j),
            k => K_sig(j),
            clk => clk,
            clear => clear,
            y => out_sig(j)
        );
    end generate;

    C_out <= prev_AND(size);
    A_out <= out_sig;

end architecture structural;