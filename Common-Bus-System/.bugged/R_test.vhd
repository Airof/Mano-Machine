library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;
use work.BUS_pkg.all;
use work.Clock_Generator_Pkg.all;

entity Rtest is


end entity Rtest;


architecture rtl of Rtest is
    
    signal R, IEN, FGI, FGO, R_J, R_K: std_logic;
    signal T: std_logic_vector(2 downto 0);
    signal RT0, RT1, RT2, clk: std_logic;

    
begin
    
    RT0 <= R and T(0);
    RT1 <= R and T(1);    
    RT2 <= R and T(2);

    clk_gen : entity work.clk_generator
        generic map (CLK_PERIOD => 1 ns)  -- Optional: Custom period
        port map (clk => clk);


    R_j <= (not (T(0) or T(1) or T(2))) and IEN and (FGI or FGO);
    R_k <= R and T(2);

    MY_jk: entity work.JKFF
        port map (
            J => R_j,
            K => R_k,
            clk => clk,
            clear => '0',
            y => R
        );
    
    
end architecture rtl;