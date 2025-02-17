library IEEE;
use IEEE.std_logic_1164.all;
use work.Clock_Generator_Pkg.all;  -- Use the package

entity my_design is
  port (
    my_clk : out std_logic
  );
end entity;

architecture struct of my_design is
begin
  -- Instantiate the clock generator
  clk_gen : clk_generator
    generic map (CLK_PERIOD => 1 ns)  -- Optional: Custom period
    port map (clk => my_clk);
end architecture;