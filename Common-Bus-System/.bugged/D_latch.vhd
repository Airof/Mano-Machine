library IEEE;
use IEEE.std_logic_1164.all;

entity D_Latch_struct is
   port(
      d     : in  std_logic;
      en    : in  std_logic;
      clear : in  std_logic;  -- Asynchronous clear (active high)
      q     : out std_logic
   );
end entity D_Latch_struct;

architecture Structural of D_Latch_struct is
   signal d_bar   : std_logic;
   signal S, R    : std_logic;  -- SR latch inputs
   signal Q_int, Q_bar : std_logic;  -- Internal SR latch signals
   signal clear_n : std_logic;  -- Inverted clear
begin
   -- Generate inverted D
   d_bar <= not d;
   
   -- Generate the S and R inputs for the SR latch
   S <= not(d and en);
   R <= not(d_bar and en);
   
   -- Generate inverted clear signal
   clear_n <= not clear;

   -- Cross-coupled NAND gates forming the SR latch with clear
   Q_int <= not(S and Q_bar and clear_n);
   Q_bar <= not(R and Q_int and clear_n);
   
   -- Output q directly from Q_int
   q <= Q_int;
end architecture Structural;