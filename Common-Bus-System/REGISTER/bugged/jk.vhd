library IEEE;
use IEEE.std_logic_1164.all;

entity JK_FF is
    port (
        J, K    : in  std_logic;
        CLK     : in  std_logic;
        reset   : in  std_logic;  -- Active-low async reset
        preset  : in  std_logic;  -- Active-low async preset
        Q       : out std_logic;
        Qbar    : out std_logic
    );
end JK_FF;

architecture Structural of JK_FF is
    component SR port (S, R : in std_logic; Q : out std_logic); end component;

    signal master_Q, slave_Q   : std_logic;
    signal CLK_n, J_gate, K_gate : std_logic;
    signal S_master, R_master, S_slave, R_slave : std_logic;
begin
    -- Clock inversion for master-slave isolation
    CLK_n <= NOT CLK after 1 ps;  -- Delay breaks combinational path

    -- Master stage gates
    J_gate <= J AND CLK AND (NOT slave_Q) after 1 ps;
    K_gate <= K AND CLK AND slave_Q after 1 ps;
    
    -- Master SR latch
    Master: SR port map(
        S => J_gate OR (NOT preset),
        R => K_gate OR (NOT reset),
        Q => master_Q
    );

    -- Slave stage gates
    S_slave <= master_Q AND CLK_n after 1 ps;
    R_slave <= (NOT master_Q) AND CLK_n after 1 ps;
    
    -- Slave SR latch
    Slave: SR port map(
        S => S_slave,
        R => R_slave,
        Q => slave_Q
    );

    -- Final outputs
    Q <= slave_Q;
    Qbar <= NOT slave_Q;
end Structural;