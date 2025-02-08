library IEEE;
use IEEE.std_logic_1164.all;
use work.Bus_pkg.all;

-- use IEEE.numeric_std.all;

entity Mano_machine is
    port (
        clk: in std_logic
    );
end entity Mano_machine;


architecture structural of Mano_machine is
    
-- list of registers PC AR IR TR DR AC

    -- Declare a single record to store all register values
    signal value: Register_Values;
    signal load: Register_Name;
    signal CLR: Register_Name;
    signal INC: Register_Name;
    signal Wr: std_logic;


    -- BUS selectors
    signal X: std_logic_vector(7 downto 0); --encoded type for select
    signal sel: std_logic_vector(2 downto 0); --decoded
    --Bus outputs
    signal on_BUS: std_logic_vector(15 downto 0);
    -- stores the ALU outpus
    signal ALU_output: std_logic_vector(16 downto 0);
    -- the overflow bit of the accumulator
    signal E: std_logic;


-- ###########Timing and Control signals###################
    signal T: std_logic_vector(15 downto 0); --Timing signal
    signal D: std_logic_vector(7 downto 0);  --control signal 
    signal B: std_logic_vector(11 downto 0); --regisrter and I/O
    signal I: std_logic;                     --regisrter and I/O
    signal R: std_logic;                     -- intrupt

    signal IEN: std_logic;                   -- intrupt enable
    signal FGO, FGI: std_logic;              -- I/O flags

    signal TC: time_control;


    -- 
    signal memory_enable, R_flag: std_logic; --for read and write flag

begin
-- ###############################################################    
-- $$$$$$$$$the basic computer timing for sequential process$$$$$$$

    time_and_control: entity work.Timing port map(
        IR => value.IR,
        increment => '1',
        clear => clr.SC,
        clk => clk,
        T => T,
        D => D,
        B => B,
        I => I
    );



-- #########################################################
-- $$$$$$$$$computing the time and control signals for registers$$$$$$$

    -- Assign all fields at once using an aggregate
    TC <= (
        -- Fetch and Decode
        nRT0   => not R and T(0),
        nRT1   => not R and T(1),
        nRT2   => not R and T(2),
        nD7IT3  => not D(7) and I and T(3),
        RT0    => R and T(0),
        RT1    => R and T(1),
        RT2    => R and T(2),

        -- Memory-reference
        D0T4   => D(0) and T(4),
        D0T5   => D(0) and T(5),
        D1T4   => D(1) and T(4),
        D1T5   => D(1) and T(5),
        D2T4   => D(2) and T(4),
        D2T5   => D(2) and T(5),
        D3T4   => D(3) and T(4),
        D4T4   => D(4) and T(4),
        D5T4   => D(5) and T(4),
        D5T5   => D(5) and T(5),
        D6T4   => D(6) and T(4),
        D6T5   => D(6) and T(5),
        D6T6   => D(6) and T(6),

        -- Register-reference
        r      => D(7) and I and T(3),
        rB11   => TC.r and B(11),
        rB10   => TC.r and B(10),
        rB9    => TC.r and B(9),
        rB8    => TC.r and B(8),
        rB7    => TC.r and B(7),
        rB6    => TC.r and B(6),
        rB5    => TC.r and B(5),
        rB4    => TC.r and B(4),
        rB3    => TC.r and B(3),
        rB2    => TC.r and B(2),
        rB1    => TC.r and B(1),
        rB0    => TC.r and B(0),

        -- Input-Output
        p    => D(7) and (not I) and T(3),
        pB11 => TC.p and B(11),
        pB10 => TC.p and B(10),
        pB9  => TC.p and B(9),
        pB8  => TC.p and B(8),
        pB7  => TC.p and B(7),
        pB6  => TC.p and B(6)
    );

-- #########################################################
-- $$$$$$ choose and decode the selectors for Bus $$$$$$$$$$

    -- X(0) <= '0'; -- not selected 

    X(1) <= '0'; -- AR

    X(2) <= TC.nRT0 OR TC.RT0; -- PC

    X(3) <= '0'; -- DR

    X(4) <= '0'; -- AC

    X(5) <= TC.nRT2; -- IR

    X(6) <= TC.RT1; -- TR

    X(7) <= TC.nRT1 OR TC.ND7IT3; -- MEMORY//also use as read



    select_selector: entity work.enc8to3 
        port map (
            input => X,
            output => sel
        );
-- #########################################################
-- $$$$$$ finding Effective address $$$$$$$$$





-- load of the registers
    load.AR <= TC.nRT0 OR TC.nRT2 OR TC.ND7IT3;

    load.PC <= '0';

    load.DR <= '0';
    
    load.AC <= '0';
    
    load.IR <= TC.nRT1;
    
    load.TR <= TC.RT0;

    wr <= TC.RT1;



-- CLEAR of the registers
    CLR.AR <= TC.RT0;
    
    CLR.PC <= TC.RT1;

    CLR.DR <= '0';

    CLR.AC <= '0';
    
    CLR.IR <= '0';
    
    CLR.TR <= '0';
 
    -- clear of the sequence counter
    clr.SC <= clr.SC and not TC.RT2;

-- INCREMENT of the registers
    INC.AR <= '0';

    INC.PC <= TC.nRT1 OR TC.RT2;

    INC.DR <= '0';
    
    INC.AC <= '0';
    
    INC.IR <= '0';
    
    INC.TR <= '0';



-- Handling the intrupt flags

    -- intrupt check
    R <= ( ((not (T(0) OR T(1))) OR T(2)) and IEN and (FGI OR FGO) ) OR ( R and TC.RT2 );


    -- inrupt enable 
    IEN <= (IEN and not TC.RT2);




    -- ALU_unit: entity work.ALU port map(
        
        
    -- );

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
-- ########### REGISTERS #######################
    AR_reg: entity work.reg12 
        port map(
            count => INC.AR,
            load => load.AR,
            clear => clr.AR,
            I => on_BUS(11 downto 0),
            clk => clk,
            A_out => value.AR,
            C_out => open
        );

    PC_reg: entity work.reg12 
        port map(
            count => INC.PC,
            load => load.PC,
            clear => clr.PC,
            I => on_BUS(11 downto 0),
            clk => clk,
            A_out => value.PC,
            C_out => open
        );

    DR_reg: entity work.reg16 
        port map(
            count => INC.DR,
            load => load.DR,
            clear => clr.DR,
            I => on_BUS,
            clk => clk,
            A_out => value.DR,
            C_out => open
        );

    AC_reg: entity work.reg16 
        port map(
            count => INC.AC,
            load => load.AC,
            clear => clr.AC,
            I => ALU_output(15 downto 0),
            clk => clk,
            A_out => value.AC,
            C_out => open
        );
        E <= ALU_output(16);


    IR_reg: entity work.reg16 
        port map(
            count => INC.IR,
            load => load.IR,
            clear => clr.IR,
            I => on_BUS,
            clk => clk,
            A_out => value.IR,
            C_out => open
        );

    TR_reg: entity work.reg16 
        port map(
            count => INC.TR,
            load => load.TR,
            clear => clr.TR,
            I => on_BUS,
            clk => clk,
            A_out => value.TR,
            C_out => open
        );


-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
-- ############## RAM ##########################

    memory_enable <=  X(7) XOR WR;
    R_flag  <=  (not X(7)) and WR;

    Memory: entity work.RAM
        port map(
            addr =>  value.AR,
            input_data => on_BUS,
            output_data => on_BUS,
            memory_enable => memory_enable, --to check RD and WR won't be high at the same time
            R_flag => R_flag
        );

end architecture structural;