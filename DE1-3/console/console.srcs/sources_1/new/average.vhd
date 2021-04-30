
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity average is 
    Port (
        clk         : in  std_logic;                    -- Main clock
        reset       : in  std_logic;                    -- Synchronous reset
        sonda       : in std_logic;                     -- Wheel spin
        wheel       : in std_logic_vector(1 downto 0);  -- Wheel size
        o_avg_speed : out unsigned(31 downto 0)         -- Average speed
   );
end average;

architecture Behavioral of average is
    signal s_avg_speed : unsigned(31 downto 0):="00000000000000000000000000000000";
    signal s_time      : unsigned(15 downto 0):="0000000000000000";
    signal s_distance  : unsigned(31 downto 0):="00000000000000000000000000000000";
begin
    p_average : process(clk)
    begin
        if rising_edge(clk) then
            if reset='1' then                               --Synchronous reset
            s_avg_speed <="00000000000000000000000000000000";
            s_time      <="0000000000000000";
            s_distance  <="00000000000000000000000000000000";
            
            elsif sonda='1' then                             --On risinge edge of clock, check if wheel turned                                
                case wheel is
                    when "00" =>                             --Depending on size of the wheel, add to distance traveled in 208*3,6*1000
                        s_distance<=s_distance + 748800;                  
                    when "01" =>
                        s_distance<=s_distance + 777600;
                    when "10" =>
                        s_distance<=s_distance + 802800; 
                    when others =>
                        s_distance<=s_distance + 831600;
                end case;
                
                if(not(s_time=0) AND not(s_distance=0)) then --To prevent division by 0, check if time was set
                    s_avg_speed<=s_distance/s_time;
                end if;
            end if;
            
        elsif (falling_edge(clk) AND not(s_distance = 0))then --If wheel didn't turned this time, add 10ms to total time
            s_time<=s_time+10;
        end if;
        
    end process p_average;
    
    o_avg_speed<=s_avg_speed;                                 --Return value
    
end Behavioral;
