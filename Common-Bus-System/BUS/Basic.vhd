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

    -- BUS selectors
    signal sel: std_logic_vector(2 downto 0);
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



begin
    
    time_and_control: entity work.Timing port map(
        IR => val.IR,
        increment => '1',
        clear => clr.SC,
        clk => clk,
        T => T,
        D => D,
        B => B,
        I => I
    );
-- load of the registers
    load.PC <= 0;

    load.AR <= 0;

    load.IR <= 0;

    load.TR <= 0;

    load.DR <= 0;

    load.AC <= 0;



-- load of the registers
    CLR.AR <= 0;
    
    CLR.PC <= 0;

    CLR.DR <= 0;

    CLR.AC <= 0;
    
    CLR.IR <= 0;
    
    CLR.TR <= 0;
 
     

-- load of the registers
    INC.AR <= 0;

    INC.PC <= 0;

    INC.DR <= 0;
    
    INC.AC <= 0;
    
    INC.IR <= 0;
    
    INC.TR <= 0;



    ALU_unit: entity work.ALU port map(
        
        
    );

-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
-- ########### REGISTERS #######################
    AR_reg: entity work.reg16 
        port map(
            count => INC.AR,
            load => load.AR,
            I => on_BUS,
            clk => clk,
            A_out => value.AR,
            cout => open
        );

    PC_reg: entity work.reg16 
        port map(
            count => INC.PC,
            load => load.PC,
            I => on_BUS,
            clk => clk,
            A_out => value.PC,
            cout => open
        );

    DR_reg: entity work.reg16 
        port map(
            count => INC.DR,
            load => load.DR,
            I => on_BUS,
            clk => clk,
            A_out => value.DR,
            cout => open
        );

    AC_reg: entity work.reg16 
        port map(
            count => INC.AC,
            load => load.AC,
            I => ALU_output,
            clk => clk,
            A_out => value.AC,
            cout => open
        );

    IR_reg: entity work.reg16 
        port map(
            count => INC.IR,
            load => load.IR,
            I => on_BUS,
            clk => clk,
            A_out => value.IR,
            cout => open
        );

    TR_reg: entity work.reg16 
        port map(
            count => INC.TR,
            load => load.TR,
            I => on_BUS,
            clk => clk,
            A_out => value.TR,
            cout => open
        );


-- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
-- ############## RAM ##########################

    -- Memory: entity work.RAM
    --     port map(
    --         addr: E_addr
    --     );

end architecture structural;