-----------------------------------------------------------------
-- This is testbench for reset.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_reset is
end tb_reset;

architecture Behavioral of tb_reset is
    -- Local signals
    signal s_button1_reset  : std_logic;  
    signal s_button2_reset  : std_logic;  
    
    signal s_reset : std_logic;
begin
    uut_reset : entity work.reset
        port map (
            i_button1_reset => s_button1_reset,
            i_button2_reset => s_button2_reset,
            
            o_reset         => s_reset
        );
        
        ----------------------------------------------------------------------
        -- Data generation process 
        ----------------------------------------------------------------------
        p_stimulus : process
        begin
            -- Report a note at the begining of stimulus process
            report "Stimulus process started" severity note;
            
            s_button1_reset <= '0'; 
            s_button2_reset <= '0'; wait for 100 ms;
            
            s_button1_reset <= '1'; wait for 100 ms;
            s_button2_reset <= '1'; wait for 100 ms;
            
            s_button1_reset <= '0'; wait for 100 ms;
            s_button2_reset <= '1'; wait for 100 ms;
            
            s_button1_reset <= '1'; 
            s_button2_reset <= '1'; wait for 100 ms;
            
            s_button1_reset <= '1'; wait for 100 ms;
            s_button2_reset <= '0'; wait for 100 ms;
            
            s_button1_reset <= '0'; wait for 100 ms;
            s_button2_reset <= '0'; wait for 100 ms;
            
            report "Stimulus process finished" severity note;
            wait;
        end process p_stimulus;
end Behavioral;
