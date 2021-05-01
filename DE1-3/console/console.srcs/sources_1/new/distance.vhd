-----------------------------------------------------------------
-- This is module for distance.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity distance is
    Port (
        clk        : in  std_logic;                   -- Main clock
        reset      : in  std_logic;                   -- Synchronous reset
        i_sonda    : in  std_logic;                   -- Wheel spin
        i_wheel    : in  std_logic_vector(1 downto 0);-- Wheel size
        i_mode     : in  std_logic_vector(1 downto 0);-- Mode input
        
        o_distance : out unsigned(31 downto 0)        -- Distance from start
   );
end distance;

architecture Behavioral of distance is
    signal s_distance : unsigned(31 downto 0):="00000000000000000000000000000000";  --Internal 32b signal to count distance
begin
    p_distance : process(clk)
    begin
        if rising_edge(clk) then
            if reset='1' then                        --Synchronous reset
                s_distance<="00000000000000000000000000000000";
                
            elsif i_sonda='1' then                   --On risinge edge of clock, check if wheel turned 
                case i_wheel is
                    when "00" =>                     --Depending on size of the wheel, add to distance traveled in cm
                        s_distance<=s_distance + 208;
                    when "01" =>
                        s_distance<=s_distance + 216;
                    when "10" =>
                        s_distance<=s_distance + 223; 
                    when others =>
                        s_distance<=s_distance + 231;
                end case; 
            end if;
        end if;
        
        if i_mode = "11" then
            o_distance <= s_distance/100;                       --Return value in 1m if mode is "11" (3)
            
        else 
            o_distance <= "00000000000000000000000000000000";   --Return value if mode isn't "11" (3)
            
        end if;
        
    end process p_distance;
end Behavioral;
