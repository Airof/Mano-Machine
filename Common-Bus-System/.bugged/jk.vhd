library IEEE;
use IEEE.std_logic_1164.all;

-- warnig line 37 and 38 have after 1pps which is not structrul
-- the problem is that feedback  signals cause infinite loop in simulations

entity JKFF_struct is
   port(
      J, K, CLK, clear : in  std_logic;
      q                : out std_logic
   );
end entity JKFF_struct;

architecture Structural of JKFF_struct is
   signal q_master, q_bar_master : std_logic := '0';
   signal q_slave, q_bar_slave   : std_logic := '0';
   signal clk_inv                : std_logic;
   signal S_master, R_master     : std_logic;
   signal S_slave, R_slave       : std_logic;
   signal clear_n                : std_logic;
begin
   -- Generate inverted clock
   clk_inv <= not CLK;

   -- Generate inverted clear
   clear_n <= not clear;

   -- Master stage SR latch inputs
   S_master <= not (J and q_bar_master and CLK);
   R_master <= not (K and q_master and CLK);

   -- Master SR latch (with feedback stabilization)
   q_master      <= not (S_master and q_bar_master and clear_n) after 1 ns;
   q_bar_master  <= not (R_master and q_master and clear_n) after 1 ns;

   -- Slave stage SR latch inputs
   S_slave <= not (q_master and clk_inv);
   R_slave <= not (q_bar_master and clk_inv);

   -- Slave SR latch (Final output)
   q_slave      <= not (S_slave and q_bar_slave and clear_n) after 1 ps;
   q_bar_slave  <= not (R_slave and q_slave and clear_n) after 1 ps;

   -- Assign internal signal to output
   q <= q_slave;

end architecture Structural;
