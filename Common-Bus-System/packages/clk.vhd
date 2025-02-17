library IEEE;
use IEEE.std_logic_1164.all;

-- Package declaration
package Clock_Generator_Pkg is
  component clk_generator
    generic (
      CLK_PERIOD : time := 10 ps  -- Default: 10 ps (adjust as needed)
    );
    port (
      clk : out std_logic
    );
  end component;
end package;

-- Entity and architecture
library IEEE;
use IEEE.std_logic_1164.all;

entity clk_generator is
  generic (
    CLK_PERIOD : time := 10 ps
  );
  port (
    clk : out std_logic := '0'  -- Initialize to '0'
  );
end entity;

architecture Behavioral of clk_generator is
begin
  -- Clock generation process
  process
  begin
    clk <= '0';
    wait for CLK_PERIOD / 2;
    clk <= '1';
    wait for CLK_PERIOD / 2;
  end process;
end architecture;