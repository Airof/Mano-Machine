library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


-- a decoder for decoding the address of the RAM
-- For a 12-bit input (addr), the Cell_selector(addr) set to '1'.
-- All other outputs remain '0'.
entity DEC12to4096 is
    port (
        addr: in std_logic_vector(11 downto 0);
        Cell_selector: out std_logic_vector(4095 downto 0);
        enable: in std_logic
    );
end entity DEC12to4096;


architecture structural of DEC12to4096 is

-- used components are DEC4to16
-- used signals are level1_enables // level2_enables
    component DEC4to16 is
        port (
            W: in std_logic_vector(3 downto 0);
            Y: out std_logic_vector(15 downto 0);
            enable: in std_logic
        );
    end component;
    signal level1_enables : std_logic_vector(15 downto 0); -- for sending U1_Level1 output to U2_Level2
    signal level2_enables : std_logic_vector(255 downto 0); -- for sending U2_Level2 output to U3_Level3
begin
 
    -- 1st level of decoders
    -- using enable as a port input
    -- one 4x16 decoder for generating the enable of level 2 decoders
    U1_Level1: DEC4to16
    port map (
        W      => addr(11 downto 8),
        Y      => level1_enables,
        enable => enable
    );

    -- 2nd level of decoders
    -- use signals shot by the U1 as enables 
    -- 16 of 4x16 decoders for generatig the enable of level 3 decoders
    GEN_Level2: for i in 0 to 15 generate
    U2_Level2: DEC4to16
        port map (
            W      => addr(7 downto 4),
            Y      => level2_enables(i*16 + 15 downto i*16),
            enable => level1_enables(i)
        );
    end generate GEN_Level2;

    -- 3rd level of decoders
    -- use signals shot by the U2 as enables
    --  256 of 4x16 decoders for generating the decoder value of addr
    GEN_Level3: for j in 0 to 255 generate
    U3_Level3: DEC4to16
        port map (
            W      => addr(3 downto 0),
            Y      => Cell_selector(j*16 + 15 downto j*16),
            enable => level2_enables(j)
        );
    end generate GEN_Level3;

end architecture structural;



-- Truth Table for 12-to-4096 Decoder:
-- ... 
-- ...... 
-- .......... 
-- #AND IM NOT GONNA WRITE YOU GUYS A 4096*4096 TRUTH TABLE IN THIS FILE.#
