library IEEE;
use IEEE.std_logic_1164.all;


entity SR is
    port (
        S, R: in std_logic;
        Q: out std_logic
    );
end entity SR;

architecture structural of SR is
    signal notQ: std_logic ;
    signal Q_int: std_logic;
begin

    notQ <= (R or Q_int) after 1 ps;  -- Delta delay breaks loop
    Q_int <= (S or notQ) after 1 ps;  -- Delta delay breaks loop
    Q <= Q_int;

end architecture structural;
