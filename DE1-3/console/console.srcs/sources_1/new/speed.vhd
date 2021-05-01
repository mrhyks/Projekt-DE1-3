-----------------------------------------------------------------
-- This is module for speed.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity speed is
    Port (
        clk        : in  std_logic;                   -- Main clock
        i_sonda    : in  std_logic;                   -- Wheel spin
        i_wheel    : in  std_logic_vector(1 downto 0);-- Wheel size
        i_mode     : in  std_logic_vector(1 downto 0);-- Mode input
        
        o_speed    : out unsigned(31 downto 0)        -- Output signal    
   );
end speed;

architecture Behavioral of speed is
    signal s_speed: unsigned(31 downto 0):="00000000000000000000000000000000"; --Internal signal to count speed
    signal s_time : unsigned(31 downto 0):="00000000000000000000000000000000"; --Internal signal to count time
begin
    p_speed : process(clk)
    begin
        
        if rising_edge(clk) then
            if i_sonda = '0' then
                s_time<=s_time+10;
                
            elsif rising_edge(i_sonda) or i_sonda = '1' then
                case i_wheel is
                    when "00" =>
                        s_speed<=748800/s_time;
                        
                    when "01" =>
                        s_speed<=777600/s_time;
                        
                    when "10" =>
                        s_speed<=802800/s_time;
                        
                    when others =>
                        s_speed<=831600/s_time;
                        
                end case; 
                s_time<="00000000000000000000000000000000";
                
            end if; 
        end if;

        if i_mode = "01" then
            o_speed <= s_speed;                             --Return value if mode is "01" (1)
            
        else 
            o_speed <= "00000000000000000000000000000000";  --Return value if mode isn't "01" (1)
            
        end if;
        
    end process p_speed;
end Behavioral;
