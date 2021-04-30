-----------------------------------------------------------------
-- This is testbench for buttons.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_buttons is
end tb_buttons;

architecture Behavioral of tb_buttons is
    -- Local signals
    signal s_BTN0  : std_logic;
    signal s_BTN1  : std_logic;
    signal s_RESET : std_logic;
          
    signal s_MODE  : std_logic_vector(1 downto 0);
    signal s_WHEEL : std_logic_vector(1 downto 0);
begin

    uut_buttons : entity work.buttons
        port map(
            i_BTN0  => s_BTN0,  
            i_BTN1  => s_BTN1,
            
            o_RESET => s_RESET,
            o_MODE  => s_MODE,
            o_WHEEL => s_WHEEL
        );
        
        ----------------------------------------------------------------------
        -- Data generation process 
        ---------------------------------------------------------------------- 
        p_stimulus : process
        begin
            -- Report a note at the begining of stimulus process
            report "Stimulus process started" severity note;
            
            s_BTN0 <= '0';
            s_BTN1 <= '0'; wait for 100 ms;
            
            s_BTN0 <= '1'; 
            s_BTN1 <= '0'; wait for 250 ms;
            
            s_BTN0 <= '0';
            s_BTN1 <= '1'; wait for 250 ms;
            
            s_BTN0 <= '1';
            s_BTN1 <= '0'; wait for 250 ms;
            
            s_BTN0 <= '0'; wait for 250 ms;
            s_BTN0 <= '1'; 
            s_BTN1 <= '1'; wait for 2000 ms;
            
            s_BTN0 <= '0';
            s_BTN1 <= '1'; wait for 250 ms;
            
            s_BTN0 <= '1';
            s_BTN1 <= '0'; wait for 250 ms;
            
            s_BTN0 <= '0';
            s_BTN1 <= '1'; wait for 250 ms;
            
            s_BTN0 <= '0';
            s_BTN1 <= '0'; wait for 250 ms;
            
            s_BTN0 <= '1';
            s_BTN1 <= '1'; wait for 250 ms;
            
            s_BTN0 <= '1';
            s_BTN1 <= '0'; wait for 250 ms;
            
            s_BTN0 <= '0';
            s_BTN1 <= '1'; wait for 250 ms;
            
            s_BTN0 <= '1';
            s_BTN1 <= '0'; wait for 250 ms;
            
            s_BTN0 <= '0';
            s_BTN1 <= '1'; wait for 250 ms;
            s_BTN1 <= '0';
            
            report "Stimulus process finished" severity note;
            wait;
        end process p_stimulus;
end Behavioral;
