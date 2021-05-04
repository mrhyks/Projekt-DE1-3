-----------------------------------------------------------------
-- Engineer: 
-- 
-- Create Date: 28.04.2021 17:36:27
-- Design Name: console
-- Module Name: top - Behavioral
-- Project Name: Console for exercise bike
-- Description: 
-- 
-----------------------------------------------------------------
-- This is top module
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity top is
    Port ( 
        btn         : in  std_logic_vector(1 downto 0);     -- Button input
        CLK100MHZ   : in  std_logic;                        -- Clock input
        ck_io5      : in  std_logic;                        -- Hall sensor input
        
        o_SPEED     : out unsigned(31 downto 0);
        o_AVG_SPEED : out unsigned(31 downto 0);
        o_DISTANCE  : out unsigned(31 downto 0);
        
        -- Input to Pmod SSD seven-segment 
        JA          : out std_logic_vector(6 downto 0);-- Output to first 7 seg
        JB          : out std_logic_vector(6 downto 0);-- Output to second 7 seg
        JC          : out std_logic_vector(6 downto 0);-- Output to third 7 seg
        JD          : out std_logic_vector(6 downto 0);-- Output to fourth 7 seg
        
        digit0_o    : out unsigned(3 downto 0);        -- Output of first digit
        digit1_o    : out unsigned(3 downto 0);        -- Output of second digit
        digit2_o    : out unsigned(3 downto 0);        -- Output of third digit
        digit3_o    : out unsigned(3 downto 0)         -- Output of fourth digit

    );
end top;

------------------------------------------------------------------------
-- Architecture body
------------------------------------------------------------------------
architecture Behavioral of top is
    signal reset       : std_logic;                   -- Internal reset signal
    signal MODE        : std_logic_vector(1 downto 0);-- Internal mode signal
    signal WHEEL       : std_logic_vector(1 downto 0);-- Internal wheel signal
    signal s_SPEED     : unsigned(31 downto 0);       -- Internal speed signal   
    signal s_AVG_SPEED : unsigned(31 downto 0);       -- Internal average speed signal    
    signal s_DISTANCE  : unsigned(31 downto 0);       -- Internal distance signal
    
    -- For testing of 7 segments 
    signal s_segmentA  : std_logic_vector(3 downto 0);-- Internal segment A signal
    signal s_segmentB  : std_logic_vector(3 downto 0);-- Internal segment B signal
    signal s_segmentC  : std_logic_vector(3 downto 0);-- Internal segment C signal
    signal s_segmentD  : std_logic_vector(3 downto 0);-- Internal segment D signal
    
    -- Separate inner counters of speed, avg speed and distance to 4 digits
    signal s_digit0    : unsigned(3 downto 0);
    signal s_digit1    : unsigned(3 downto 0);
    signal s_digit2    : unsigned(3 downto 0);
    signal s_digit3    : unsigned(3 downto 0);
       
begin    
    --------------------------------------------------------------------
    -- Instance (copy) of buttons entity
    buttons : entity work.buttons
    port map(
        clk     => CLK100MHZ,
        i_BTN0  => btn(0),
        i_BTN1  => btn(1),
        o_MODE  => MODE,
        o_RESET => reset,
        o_WHEEL => WHEEL        
    );
    
    --------------------------------------------------------------------
    -- Instance (copy) of calculations entity
    --------------------------------------------------------------------
    -- SPEED and AVG_SPEED are displayed in km/h - last 2  numbers 
    -- are decimal numbers, for example SPEED 1983 is 19,83 km/h
    -- 
    -- DISTANCE is displayed in meters, numbers are rounded
    calc : entity work.calculations
    port map (
        clk     => CLK100MHZ,
        i_reset => reset,
        i_probe => ck_io5,
        i_MODE  => MODE,
        i_WHEEL => WHEEL,
        o_SPD   => s_SPEED,
        o_AVGS  => s_AVG_SPEED,
        o_DIST  => s_DISTANCE
    );
    --------------------------------------------------------
    --Depending on selected mode, this module will convert value of inner counter to 4 digits    
    p_convert : entity work.convert_to_4digit
    port map (
        clk      => CLK100MHZ,
        i_sensor => ck_io5,
        i_MODE   => MODE,
        i_SPD    => s_SPEED,
        i_AVGS   => s_AVG_SPEED,
        i_DIST   => s_DISTANCE,
        o_D0     => s_digit3,
        o_D1     => s_digit2,
        o_D2     => s_digit1,
        o_D3     => s_digit0
    );
    --------------------------------------------------------
    --Convert previously gained 4 digits
    --Use same module to convert 4 different values
    hex7segA : entity work.hex7seg
        port map(
            hex_i => s_digit0,
            seg_o => s_segmentA       
        );
        
    hex7segB : entity work.hex7seg
        port map(
            hex_i => s_digit1,
            seg_o => s_segmentB       
        );
        
   hex7segC : entity work.hex7seg
        port map(
            hex_i => s_digit2,
            seg_o => s_segmentC       
        );
   hex7segD : entity work.hex7seg
        port map(
            hex_i => s_digit3,
            seg_o => s_segmentD       
        );
    --Retype unsigned to std_logic_vector
    JD <= std_logic_vector(s_digit3);
    JC <= std_logic_vector(s_digit2);
    JB <= std_logic_vector(s_digit1);
    JA <= std_logic_vector(s_digit0);
    
    --Output inner signals
    o_SPEED<=s_SPEED;
    o_AVG_SPEED<=s_AVG_SPEED;
    o_DISTANCE<=s_DISTANCE;
    
    digit0_o<=s_digit0;
    digit1_o<=s_digit1;
    digit2_o<=s_digit2;
    digit3_o<=s_digit3;
    
end Behavioral;
