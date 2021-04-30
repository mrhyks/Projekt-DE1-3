
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity speed is
    Port (
        clk        : in  std_logic;                   -- Main clock
        reset      : in  std_logic;                   -- Synchronous reset
        i_sonda    : in  std_logic;                   -- Wheel spin
        i_wheel    : in  std_logic_vector(1 downto 0);-- Wheel size
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
            if i_sonda = '1' then           
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
            end if;
            
        elsif i_sonda='1' then
            if falling_edge(clk) then
                s_time<="00000000000000000000000000000000";
            end if; 
             
        elsif falling_edge(clk) then
            s_time<=s_time+10;
            
            if s_time>2000 then    
                s_speed<="00000000000000000000000000000000";
            end if;   
        end if;
    end process p_speed;
    
    o_speed<=s_speed;
    
end Behavioral;
