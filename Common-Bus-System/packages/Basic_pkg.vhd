library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Bus_Pkg is

    component RAM is 
        port(
            addr : in std_logic_vector(11 downto 0);
            input_data : in std_logic_vector(15 downto 0);
            output_data : out std_logic_vector(15 downto 0);
            memory_enable : in std_logic;
            R_flag : in std_logic
        );
    end component RAM;

    component Timing is
        port (
            IR: in std_logic_vector(15 downto 0);
            increment,clk,clear: in std_logic;
            T: out std_logic_vector(15 downto 0); --Timing signal
            D: out std_logic_vector(7 downto 0);  --control signal 
            B: out std_logic_vector(11 downto 0); --regisrter and I/O
            I: out std_logic                      --regisrter and I/O
        );
    end component Timing;


    component reg16 is
        generic(
            size: integer := 16
        );
        port(
            Count, load : in std_logic;
            I : in std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
            Clk, Clear : in std_logic;
            A_out : out std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
            C_out : out std_logic
        );
    end component;


    component reg12 is
        generic(
            size: integer := 12
        );
        port(
            Count, load : in std_logic;
            I : in std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
            Clk, Clear : in std_logic;
            A_out : out std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
            C_out : out std_logic
        );
    end component;


    component reg8 is
        generic(
            size: integer := 8
        );
        port(
            Count, load : in std_logic;
            I : in std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
            Clk, Clear : in std_logic;
            A_out : out std_logic_vector(size-1 downto 0);  -- Changed to 7 bits
            C_out : out std_logic
        );
    end component;

    
    component ALU is
        port (
            S : in std_logic_vector(3 downto 0);
            cin: std_logic;
            A, B: in std_logic_vector(15 downto 0);
            F: out std_logic_vector(15 downto 0);
            E: out std_logic
        );
    end component ALU;

    component Bus7 is
        port (
            inp1,inp2,inp3,inp4,inp5,inp6,inp7:
                 in std_logic_vector(15 downto 0);
            sel: in std_logic_vector(2 downto 0);
            on_BUS: out std_logic_vector(15 downto 0)
        );
    end component Bus7;


    component enc8to3 is
        port (
            input: in std_logic_vector(7 downto 0);
            output: out std_logic_vector(2 downto 0)
        );
    end component enc8to3;

    component MUX2to1 is
        port (
            input : in std_logic_vector(1 downto 0);
            sel : in std_logic;
            q : out std_logic
        );
    end component MUX2to1;

    -- the file below is still not logic based

    component JKff is 
        port(
            J,K,CLK,Clear : in std_logic;
            y : out std_logic
        );
    end component;



        -- Define the record type inside the architecture
    type Register_Values is record    
        AC  : std_logic_vector(15 downto 0);
        DR  : std_logic_vector(15 downto 0);
        IR  : std_logic_vector(15 downto 0);
        AR  : std_logic_vector(11 downto 0);
        PC  : std_logic_vector(11 downto 0);
        TR  : std_logic_vector(15 downto 0);
        OUTR: std_logic_vector(7 downto 0);
        INPR: std_logic_vector(7 downto 0);
    end record;    

    type Register_Name is record
        AC  : std_logic;
        AR  : std_logic;
        DR  : std_logic;
        IR  : std_logic;
        PC  : std_logic;
        TR  : std_logic;
        SC  : std_logic;
    end record;        

    type Time_Control is record
        --fetch and decode
        nRT0   : std_logic;
        nRT1   : std_logic;
        nRT2   : std_logic;
        nD7IT3  : std_logic;
        RT0    : std_logic;
        RT1    : std_logic;
        RT2    : std_logic; -- seems that RT2 is reseaved ???
        -- Memory-reference
        D0T4   : std_logic;
        D0T5   : std_logic;
        D1T4   : std_logic;
        D1T5   : std_logic;
        D2T4   : std_logic;
        D2T5   : std_logic;
        D3T4   : std_logic;
        D4T4   : std_logic;
        D5T4   : std_logic;
        D5T5   : std_logic;
        D6T4   : std_logic;
        D6T5   : std_logic;
        D6T6   : std_logic;
        -- Register-reference
        r      : std_logic;
        rB11   : std_logic;
        rB10   : std_logic;
        rB9    : std_logic;
        rB8    : std_logic;
        rB7    : std_logic;
        rB6    : std_logic;
        rB5    : std_logic;
        rB4    : std_logic;
        rB3    : std_logic;
        rB2    : std_logic;
        rB1    : std_logic;
        rB0    : std_logic;
        -- Input-Output
        p      : std_logic;
        pB11   : std_logic;
        pB10   : std_logic; 
        pB9    : std_logic;
        pB8    : std_logic;
        pB7    : std_logic;
        pB6    : std_logic;
    end record;
end package Bus_Pkg;
