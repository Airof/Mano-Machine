library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity Timing is
    port (
        IR: in std_logic_vector(15 downto 0);
        increment,clk,clear: in std_logic;
        T: out std_logic_vector(15 downto 0); --Timing signal
        D: out std_logic_vector(7 downto 0);  --control signal 
        B: out std_logic_vector(11 downto 0); --regisrter and I/O
        I: out std_logic                      --regisrter and I/O
    );
end entity Timing;


architecture structural of Timing is

    component DEC3to8 is
        port (
            W: in std_logic_vector(2 downto 0);
            Y: out std_logic_vector(7 downto 0);
            enable: in std_logic
        );
    end component DEC3to8;
    
    component DEC4to16 is
        port (
            W: in std_logic_vector(3 downto 0);
            Y: out std_logic_vector(15 downto 0);
            enable: in std_logic
        );
    end component DEC4to16;
    
    component seq_counter is
        generic(
            size: integer := 4
        );

         port (
             increment: in std_logic;
             clear: in std_logic;
             clk: in std_logic;
             A_out: out std_logic_vector(size-1 downto 0);
             c_out: out std_logic
        );
    end component seq_counter;



    signal seq_cnt: std_logic_vector(3 downto 0);
begin


    I <= IR(15);
    D_val: DEC3to8 port map (
        W => IR(14 downto 12),
        Y => D,
        enable => '1'
    );
    B <= IR(11 downto 0);


    count: seq_counter port map(
            increment => increment,
            clear => clear,
            clk => clk,
            A_out => seq_cnt,
            c_out => open
    );

    T_val: DEC4to16 port map (
            W => seq_cnt,
            Y => T,
            enable => '1'
    );



    
end architecture structural;
