-----------------------------------------------------------------
-- This is testbench for buttons.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_buttons is
end tb_buttons;

architecture Behavioral of tb_buttons is
    -- Local signals
    signal s_clk_100MHz          : std_logic;                   -- clk signal
    signal s_BTN0                : std_logic;
    signal s_BTN1                : std_logic;
    
    signal s_RESET               : std_logic; 
    signal s_MODE                : std_logic_vector(1 downto 0);
    signal s_WHEEL               : std_logic_vector(1 downto 0);
    
    -- Local constant; Period 10 ms for countdowns in mode and wheel
    constant c_CLK_100MHZ_PERIOD : time := 10 ms;
begin

    uut_buttons : entity work.buttons
        port map(
            i_BTN0  => s_BTN0,  
            i_BTN1  => s_BTN1,
            clk     => s_clk_100MHz,
            o_RESET => s_RESET,
            o_MODE  => s_MODE,
            o_WHEEL => s_WHEEL
        );
        
        --------------------------------------------------------------------
        -- Clock generation process
        --------------------------------------------------------------------
        p_clk_gen : process
        begin
            while now < 10000 ms loop
                s_clk_100MHz <= '0';
                wait for c_CLK_100MHZ_PERIOD / 2;
                s_clk_100MHz <= '1';
                wait for c_CLK_100MHZ_PERIOD / 2;
            end loop;
            wait;
        end process p_clk_gen;
        
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
            
            s_BTN0 <= '0'; wait for 240 ms;
            s_BTN0 <= '1'; wait for 10 ms;
            s_BTN1 <= '1'; wait for 2010 ms;
            
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
