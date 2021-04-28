-----------------------------------------------------------------
-- This is design for mode.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity mode is
    Port (
        clk             : in  std_logic;                    -- clock input
        i_button1       : in  std_logic;                    -- Input for button1 (BTN0)
        i_button2       : in  std_logic;                    -- Input for button2 (BTN1)
        
        o_button1_reset : out std_logic;                    -- Output for reset.vhdl
        o_mode          : out std_logic_vector(1 downto 0)  -- Output of mode
    );
end mode;

architecture Behavioral of mode is
    -- Local signals
    signal s_mode                : unsigned(1 downto 0) := "00";
    signal s_cnt                 : unsigned(5 - 1 downto 0);
    
    -- Local constants
    constant c_DELAY_2SEC        : unsigned(5 - 1 downto 0) := b"0_1000";   -- Signal delay 2s
    constant c_ZERO              : unsigned(5 - 1 downto 0) := b"0_0000";
begin
    ------------------------------------------------------------
    -- Process for reset (o_button1_reset) signal output
    ------------------------------------------------------------
    p_button1_reset : process(i_button1,i_button2,clk)
    begin
        if (i_button1 = '1' and i_button2 = '1') then
            if (s_cnt < c_DELAY_2SEC) then
                s_cnt           <= s_cnt + 1;
                
            else
                s_cnt           <= c_ZERO;
                o_button1_reset <= '1';
                
            end if;
            
        elsif (falling_edge(i_button1) or falling_edge(i_button2)) then
            s_cnt           <= c_ZERO;
            o_button1_reset <= '0';
            
        else
            s_cnt           <= c_ZERO;
            o_button1_reset <= '0';
            
        end if;
    end process p_button1_reset;
    
    ------------------------------------------------------------
    -- Process for mode(o_mode) signal output
    ------------------------------------------------------------
    p_button1_click : process(i_button1,i_button2)
    begin
        if (i_button1 = '1' and i_button2 = '0') then
            case s_mode is
                when "00" =>
                    o_mode <= "00";
                    s_mode <= s_mode + 1;
                    
                when "01" => 
                    o_mode <= "01";
                    s_mode <= s_mode + 1;
                    
                when "10" => 
                    o_mode <= "10";
                    s_mode <= s_mode + 1;
                    
                when "11" => 
                    o_mode <= "11";
                    s_mode <= "00";
                    
                when others =>
                    s_mode <= "00";
                
            end case;
        end if; 
    end process p_button1_click;

end Behavioral;
