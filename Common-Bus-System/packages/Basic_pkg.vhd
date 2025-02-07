library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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


        -- Define the record type inside the architecture
    type Register_Values is record    
        AC  : std_logic_vector(15 downto 0);
        AR  : std_logic_vector(15 downto 0);
        DR  : std_logic_vector(15 downto 0);
        IR  : std_logic_vector(15 downto 0);
        PC  : std_logic_vector(15 downto 0);
        TR  : std_logic_vector(15 downto 0);
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

end package Bus_Pkg;
