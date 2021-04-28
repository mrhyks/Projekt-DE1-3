-----------------------------------------------------------------
-- This is testbench for mode.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mode is
end tb_mode;

architecture Behavioral of tb_mode is
    -- Local constant
    constant c_CLK_100MHZ_PERIOD : time := 500 ms;
    
    -- Local signals
    signal s_clk_100MHz          : std_logic;
    signal s_button1             : std_logic;
    signal s_button2             : std_logic;
    signal s_mode                : std_logic_vector(1 downto 0);
    signal s_button1_reset       : std_logic;
begin
    uut_mode : entity work.mode
        port map(
            clk              => s_clk_100MHz,
            i_button1        => s_button1,
            i_button2        => s_button2,
            o_mode           => s_mode,
            o_button1_reset  => s_button1_reset
        );
        
        ----------------------------------------------------------------------
        -- Clock gen. with 500 ms period for countdown of reset signal
        ----------------------------------------------------------------------
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
            
            s_button1 <= '0'; 
            s_button2 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            s_button2 <= '1'; wait for 2500 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button2 <= '0'; wait for 100 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            s_button2 <= '1'; wait for 1000 ms;
            
            s_button2 <= '0';
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            s_button1 <= '0'; wait for 250 ms;
            s_button1 <= '1'; wait for 100 ms;
            
            report "Stimulus process finished" severity note;
            wait;
        end process p_stimulus;
end Behavioral;
