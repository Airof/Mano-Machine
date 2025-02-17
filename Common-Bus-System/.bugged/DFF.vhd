library IEEE;
use IEEE.std_logic_1164.all;

entity DFF_struct is
   port(
      clk   : in  std_logic;
      clear : in  std_logic;  -- Asynchronous clear (active high)
      d     : in  std_logic;
      q     : out std_logic
   );
end entity DFF_struct;

architecture Structural of DFF_struct is
   signal q_master : std_logic;
   signal clk_inv  : std_logic;
begin
   -- Generate clock inversion for master latch
   clk_inv <= not clk;
   
   -- Master D latch (enabled when clk is low)
   master_latch: D_Latch_struct
      port map (
         d     => d,
         en    => clk_inv,
         clear => clear,
         q     => q_master
      );
      
   -- Slave D latch (enabled when clk is high)
   slave_latch: D_Latch_struct
      port map (
         d     => q_master,
         en    => clk,
         clear => clear,
         q     => q
      );
end architecture Structural;
