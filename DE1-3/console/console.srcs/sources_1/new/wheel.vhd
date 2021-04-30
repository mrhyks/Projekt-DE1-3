-----------------------------------------------------------------
-- This is design for wheel.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity wheel is
    Port (
        clk             : in  std_logic;                    -- clock input
        i_button1       : in  std_logic;                    -- Input for button1 (BTN0)
        i_button2       : in  std_logic;                    -- Input for button2 (BTN1)
        i_mode          : in  std_logic_vector(1 downto 0); -- Input for mode from design source mode.vhdl
        
        o_button2_reset : out std_logic;                    -- Output for reset.vhdl
        o_wheel         : out std_logic_vector(1 downto 0)  -- Output of wheel mode
    );
end wheel;

architecture Behavioral of wheel is
    -- Local signals
    signal wheel                 : unsigned(1 downto 0) := "00"; 
    signal s_cnt                 : unsigned(5 - 1 downto 0);
    
    -- Local constants
    constant c_DELAY_2SEC        : unsigned(5 - 1 downto 0) := b"0_1000";   -- Signal delay 2s
    constant c_ZERO              : unsigned(5 - 1 downto 0) := b"0_0000";
    
begin    
    ------------------------------------------------------------
    -- Process for reset (o_button2_reset) signal output
    ------------------------------------------------------------
    p_button2_reset : process(i_button1,i_button2,clk)
    begin
        if (i_button2 = '1' and i_button1 = '1') then
            if (s_cnt < c_DELAY_2SEC) then
                s_cnt           <= s_cnt + 1;
                
            else
                s_cnt           <= c_ZERO;
                o_button2_reset <= '1';
                
            end if;
            
        elsif (falling_edge(i_button2) or falling_edge(i_button1)) then
            s_cnt           <= c_ZERO;
            o_button2_reset <= '0';
        
        else 
            s_cnt           <= c_ZERO;
            o_button2_reset <= '0';   
            
        end if;
    end process p_button2_reset;
    
    ------------------------------------------------------------
    -- Process for wheel mode(o_wheel) signal output
    ------------------------------------------------------------
    p_button2_click : process(i_button2,i_button1)
    begin
        if (i_button2 = '1' and i_button1 = '0' and i_mode = "00") then
            case wheel is
                when "00" => 
                    o_wheel <= "00";
                    wheel   <= wheel + 1;
                    
                when "01" => 
                    o_wheel <= "01";
                    wheel   <= wheel + 1;
                    
                when "10" => 
                    o_wheel <= "10";
                    wheel   <= wheel + 1;
                    
                when "11" => 
                    o_wheel <= "11";
                    wheel   <= "00";
                    
                when others =>
                    wheel   <= "00";
                    
            end case;
        end if;    
    end process p_button2_click;
end Behavioral;
