-----------------------------------------------------------------
-- This is top module for distance.vhd, speed.vhd and average.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity calculations is
    Port ( 
        clk     : in std_logic;                     -- Clock input
        i_reset : in std_logic;                     -- Reset input
        i_probe : in std_logic;                     -- Hall sensor input
        i_MODE  : in std_logic_vector(1 downto 0);  -- Mode input
        i_WHEEL : in std_logic_vector(1 downto 0);  -- Wheel mode input
        
        o_SPD   : out unsigned(31 downto 0);        -- Speed output
        o_AVGS  : out unsigned(31 downto 0);        -- Average speed output
        o_DIST  : out unsigned(31 downto 0)         -- Travel distance output
    );
end calculations;

------------------------------------------------------------------------
-- Architecture body
------------------------------------------------------------------------
architecture Behavioral of calculations is
begin    
    -- o_SPD and o_AVGS are displayed in km/h - last 2  numbers 
    -- are decimal numbers, for example SPEED 1983 is 19,83 km/h
    -- 
    -- o_DIST is displayed in meters, numbers are rounded
    
    --------------------------------------------------------------------
    -- Instance (copy) of average entity
    average : entity work.average
    port map(
        clk         => clk,
        reset       => i_reset,
        i_sonda     => i_probe,
        i_wheel     => i_WHEEL,
        i_mode      => i_MODE,
        o_avg_speed => o_AVGS
    );
    
    --------------------------------------------------------------------
    -- Instance (copy) of speed entity
    speed : entity work.speed
    port map(
        clk     => clk,
        i_sonda => i_probe,
        i_wheel => i_WHEEL,
        i_mode  => i_MODE,
        o_speed => o_SPD
    );
    
    --------------------------------------------------------------------
    -- Instance (copy) of distance entity
    distance : entity work.distance
    port map(
        clk        => clk,
        reset      => i_reset,
        i_sonda    => i_probe,
        i_wheel    => i_WHEEL,
        i_mode     => i_MODE,
        o_distance => o_DIST
    );
end Behavioral;
