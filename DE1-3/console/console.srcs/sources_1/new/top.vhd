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
        ja         : out unsigned(7 downto 4);
        jb         : out unsigned(7 downto 4);
        jc         : out unsigned(7 downto 4);
        jd         : out unsigned(7 downto 4)
        
        -- To convert the binary output to ASCII, an external module such as
        -- Arduino will be needed, the following I/O pins would be used for transmission 
        -- ck_io0     : in  std_logic_vector(1 downto 0);       -- Input from Arduino
        -- ck_io1     : in  std_logic_vector(1 downto 0);       -- Input from Arduino
        -- ck_io2     : out std_logic_vector(31 downto 0); -- Speed output to arduino
        -- ck_io3     : out std_logic_vector(31 downto 0); -- Average speed output to arduino
        -- ck_io4     : out std_logic_vector(31 downto 0)  -- Travel distance output to arduino
        
--        SPEED     : out unsigned(31 downto 0);  -- Speed output
--        AVG_SPEED : out unsigned(31 downto 0);  -- Average speed output
--        DISTANCE  : out unsigned(31 downto 0)   -- Travel distance output
    );
end top;

------------------------------------------------------------------------
-- Architecture body
------------------------------------------------------------------------
architecture Behavioral of top is
    signal reset     : std_logic;                   -- Internal reset signal
    signal MODE      : std_logic_vector(1 downto 0);-- Internal mode signal
    signal WHEEL     : std_logic_vector(1 downto 0);-- Internal wheel signal
    signal SPEED     : unsigned(31 downto 0);
    signal AVG_SPEED : unsigned(31 downto 0);
    signal DISTANCE  : unsigned(31 downto 0);
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
    
    helper : entity work.convert_to_4digit
    port map (
        clk     => CLK100MHZ,
        i_MODE  => MODE,
        i_SPD  =>SPEED,
        i_AVGS =>AVG_SPEED,
        i_DIST =>DISTANCE,
        o_D0 => jd,
        o_D1 => jc,
        o_D2 => jb,
        o_D3 => ja
    );
    
end Behavioral;
