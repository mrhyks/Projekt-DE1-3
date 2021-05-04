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
        btn       : in  std_logic_vector(1 downto 0);   -- Button input
        CLK100MHZ : in  std_logic;                      -- Clock input
        ck_io5    : in  std_logic;                      -- Hall sensor input
        
        -- Input to Pmod SSD seven-segment 
        ja         : out std_logic_vector(6 downto 0);          -- Output to first 7 seg
        jb         : out std_logic_vector(6 downto 0);          -- Output to second 7 seg
        jc         : out std_logic_vector(6 downto 0);          -- Output to third 7 seg
        jd         : out std_logic_vector(6 downto 0)           -- Output to fourth 7 seg

    );
end top;

------------------------------------------------------------------------
-- Architecture body
------------------------------------------------------------------------
architecture Behavioral of top is
    signal reset     : std_logic;                   -- Internal reset signal
    signal MODE      : std_logic_vector(1 downto 0);-- Internal mode signal
    signal WHEEL     : std_logic_vector(1 downto 0);-- Internal wheel signal
    signal SPEED     : unsigned(31 downto 0);       -- Internal speed signal   
    signal AVG_SPEED : unsigned(31 downto 0);       -- Internal average speed signal    
    signal DISTANCE  : unsigned(31 downto 0);       -- Internal distance signal
    
    -- For testing 7segs 
    signal s_ja      : unsigned(3 downto 0);        -- Internal ja signal
    signal s_jb      : unsigned(3 downto 0);        -- Internal jb signal
    signal s_jc      : unsigned(3 downto 0);        -- Internal jc signal
    signal s_jd      : unsigned(3 downto 0);        -- Internal jd signal
       
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
        o_SPD   => SPEED,
        o_AVGS  => AVG_SPEED,
        o_DIST  => DISTANCE
    );
    
    --------------------------------------------------------------------
    -- Instance (copy) of convert_to_4digit entity
    helper : entity work.convert_to_4digit
    port map (
        clk      => CLK100MHZ,
        i_sensor => ck_io5,
        i_MODE   => MODE,
        i_SPD    => SPEED,
        i_AVGS   => AVG_SPEED,
        i_DIST   => DISTANCE,
        o_D0     => s_jd,
        o_D1     => s_jc,
        o_D2     => s_jb,
        o_D3     => s_ja
    );
    
    --------------------------------------------------------------------
    -- Instance (copy) of hex7seg entity
--    hex_7seg : entity work.hex7seg
--    port map (
--        hex0_i => s_jd,
--        hex1_i => s_jc,
--        hex2_i => s_jb,
--        hex3_i => s_ja,
--        seg0_o => jd,
--        seg1_o => jc,
--        seg2_o => jb,
--        seg3_o => ja
--    );
    
end Behavioral;
