library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

-- ALU consists of arithmetic, logic, and shift units.  
-- Uses a multiplexer to select the final result based on S(3:2).
entity ALU is
    port (
        S : in std_logic_vector(3 downto 0);
        cin: std_logic;
        A, B: in std_logic_vector(15 downto 0);
        F: out std_logic_vector(15 downto 0);
        E: out std_logic
    );
end entity ALU;


architecture structural of ALU is
-- ==========================================================================|
-- Components:                                                               |               
-- - Arithmetic: Handles addition, subtraction, increment, and decrement.    |                     
-- - LOGIC: Performs bitwise operations (AND, OR, XOR, NOT).                 |                
-- - ShiftLR: Manages logical left and right shifts.                         |                       
-- - MUX4to1: Selects the final output based on S(3:2).                      |                   
--                                                                           |     
-- Signals:                                                                  |
-- - Arith_val: Stores arithmetic results.                                   |      
-- - logic_val: Stores logic operation results.                              |  
-- - shift_val_L: Stores left shift results.                                 |           
-- - shift_val_R: Stores right shift results.                                |                
-- ==========================================================================|
    component Arithmetic is
        port (
            A, B: in std_logic_vector(15 downto 0);
            sel: in std_logic_vector(1 downto 0);
            cin: in std_logic;
            
            cout: out std_logic;
            D: out std_logic_vector(15 downto 0)
            );
        end component Arithmetic;
    

    component LOGIC is
        port (
            Sel: in std_logic_vector(1 downto 0);
            A, B: in std_logic_vector(15 downto 0);
            E: out std_logic_vector(15 downto 0)
        );
    end component LOGIC;


    component ShiftLR is
        port (
            Shift_dir: in std_logic;
            A: in std_logic_vector(15 downto 0);
            H: out std_logic_vector(15 downto 0)
        );
    end component ShiftLR;

    component MUX4to1 is
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;
        

    signal Arith_val: std_logic_vector(15 downto 0);
    signal logic_val: std_logic_vector(15 downto 0);
    signal shift_val_L: std_logic_vector(15 downto 0);
    signal shift_val_R: std_logic_vector(15 downto 0);

begin

    
    -- this block handles the mathmatical(Arithmetic) calculations
    Arithmetic_block: Arithmetic port map(
        A => A,
        B => B,
        sel => S(1 downto 0),
        cin => cin,
        cout => E,
        D => Arith_val
    );

    -- this block handles the Logical operations    
    Logic_block: LOGIC port map(
        Sel => S(1 downto 0),
        A => A,
        B=> B,
        E=> logic_val
    );

    -- this block handles the Right Shift    
    Shift_Right_block: ShiftLR port map(
        Shift_dir => '0',
        A => A,
        H => shift_val_R
    );

    -- this block handles the Left Shift
    Shift_Left_block: ShiftLR port map(
        Shift_dir => '1',
        A => A,
        H => shift_val_L
    );


    -- this block handles selection
    -- read line 148 for the truth table
    FINAL_VALUE_GEN: for i in 0 to 15 generate  
        Final_value: MUX4to1 port map(
            input(0) => Arith_val(i),
            input(1) => logic_val(i),
            input(2) => shift_val_R(i),
            input(3) => shift_val_L(i),
            sel => S(3 downto 2),
            q => F(i)
        );
    end generate;

    
end architecture structural;


-- ALU: 16-bit Arithmetic and Logic Unit (ALU)
--
--
-- Operation:
--   - The ALU performs arithmetic, logic, and shift operations.
--   - It consists of three main functional blocks:
--       1. Arithmetic block (Arithmetic): Handles addition, subtraction, etc.
--       2. Logic block (LOGIC): Performs bitwise AND, OR, XOR, and NOT.
--       3. Shift block (ShiftLR): Performs left and right logical shifts.
--   - A 4-to-1 multiplexer selects the final output based on the upper two bits of S.
--
-- Control Signals (S[3:0]):
--   S[3:2]  | Operation
--  ------------------------
--      00   | Arithmetic (Add/Sub)
--      01   | Logic (AND, OR, XOR, NOT)
--      10   | Right Shift
--      11   | Left Shift



-- ==================================================
-- ALU Control Signals and Operations:
-- ==================================================
--   S[3:0]  | cin | Operation        | Description                        
--  -------------------------------------------------------------------
--    0000   |  0  | Transfer A       | F = A                           
--    0000   |  1  | Increment A      | F = A + 1                       
--    0001   |  0  | Addition         | F = A + B                       
--    0001   |  1  | Add with Carry   | F = A + B + 1                   
--    0010   |  0  | Subtract w/borrow| F = A + NOT(B)                   
--    0010   |  1  | Subtraction      | F = A + NOT(B) + 1               
--    0011   |  0  | Decrement A      | F = A - 1                        
--    0011   |  1  | Transfer A       | F = A                            
--    0100   |  X  | AND              | F = A AND B                      
--    0101   |  X  | OR               | F = A OR B                       
--    0110   |  X  | XOR              | F = A XOR B                      
--    0111   |  X  | Complement A     | F = NOT A                        
--    100X   |  X  | Shift Right      | F = SHR(A)                       
--    110X   |  X  | Shift Left       | F = SHL(A)                        

-- ==================================================
-- Notes:
-- - 'X' means the bit is ignored for that operation.
-- - 'cin' is only relevant for arithmetic operations.
-- - Shifting operations use logical shifts.
-- - 'E' is only meaningful for arithmetic operations.

-- ==================================================
-- Used Components:
-- ==================================================
-- 1. Arithmetic:
--    - Performs addition, subtraction, increment, and decrement.
--    - Inputs: A, B (16-bit), sel (2-bit), cin (1-bit).
--    - Outputs: D (16-bit), cout (1-bit).
--
-- 2. LOGIC:
--    - Performs bitwise AND, OR, XOR, and NOT operations.
--    - Inputs: A, B (16-bit), sel (2-bit).
--    - Outputs: E (16-bit).
--
-- 3. ShiftLR:
--    - Handles logical left and right shifts.
--    - Inputs: A (16-bit), Shift_dir (1-bit).
--    - Outputs: H (16-bit).
--
-- 4. MUX4to1:
--    - Selects the final output based on S(3:2).
--    - Inputs: input (4-bit), sel (2-bit).
--    - Output: q (1-bit).
--
-- ==================================================
-- Used Signals:
-- ==================================================
-- 1. Arith_val (16-bit)  - Holds arithmetic operation result.
-- 2. logic_val (16-bit)  - Holds logical operation result.
-- 3. shift_val_L (16-bit) - Holds left shift result.
-- 4. shift_val_R (16-bit) - Holds right shift result.
