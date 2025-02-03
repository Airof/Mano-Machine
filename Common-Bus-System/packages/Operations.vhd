library IEEE;
use IEEE.std_logic_1164.all;


-- Define a package to hold the custom function
package my_logic_ops is
    function nand_gate(a, b: std_logic) return std_logic;
    function nand_gate3(a, b, c: std_logic) return std_logic;

    function nor_gate(a, b: std_logic) return std_logic;
    function nor_gate3(a, b, c: std_logic) return std_logic;
end package my_logic_ops;

package body my_logic_ops is
    -- Implementation of the NAND function
    function nand_gate(a, b: std_logic) return std_logic is
    begin
        return not (a and b);
    end function nand_gate;

    function nand_gate3(a, b, c: std_logic) return std_logic is
        begin
            return not (a and b and c);
        end function nand_gate3;

    
    function nor_gate(a, b: std_logic) return std_logic is
        begin
            return not (a and b);
        end function nor_gate;
    
    function nor_gate3(a, b, c: std_logic) return std_logic is
        begin
            return not (a and b and c);
        end function nor_gate3;

        
end package body my_logic_ops;
