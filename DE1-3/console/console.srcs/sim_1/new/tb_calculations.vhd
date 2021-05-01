-----------------------------------------------------------------
-- This is testbench for calculations.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_calculations is
end tb_calculations;

architecture Behavioral of tb_calculations is
    -- Local signals
    signal s_clk_100MHz          : std_logic;                   -- clk signal
    signal s_RESET               : std_logic;
    signal s_PROBE               : std_logic;                    
    signal s_MODE                : std_logic_vector(1 downto 0);
    signal s_WHEEL               : std_logic_vector(1 downto 0);
    
    signal s_SPD                 : unsigned(31 downto 0);
    signal s_AVGS                : unsigned(31 downto 0);
    signal s_DIST                : unsigned(31 downto 0);
    
    -- Local constant
    constant c_CLK_100MHZ_PERIOD : time := 10 ms;
begin
    uut_calculations : entity work.calculations
        port map(
            clk     => s_clk_100MHz,
            i_reset => s_RESET,
            i_probe => s_PROBE,
            i_MODE  => s_MODE,
            i_WHEEL => s_WHEEL,
            o_SPD   => s_SPD,
            o_AVGS  => s_AVGS,
            o_DIST  => s_DIST
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
        -- Artificial generator for mode signal 
        ----------------------------------------------------------------------
        p_mode_gen : process
        begin
            s_MODE <= "00"; wait for 500 ms;
            
            s_MODE <= "01"; wait for 1500 ms;
            
            s_MODE <= "10"; wait for 1500 ms;
            
            s_MODE <= "11"; wait for 1500 ms;
            
            s_MODE <= "00"; wait for 500 ms;
            
            s_MODE <= "01"; wait for 1500 ms;
            
            s_MODE <= "10"; wait for 1500 ms;
            
            s_MODE <= "11"; wait for 1500 ms;
            
            s_MODE <= "00"; 
            wait;
        end process p_mode_gen;
        
        ----------------------------------------------------------------------
        -- Data generation process 
        ---------------------------------------------------------------------- 
        p_stimulus : process
        begin
            -- Report a note at the begining of stimulus process
            report "Stimulus process started" severity note;
            
            s_RESET <= '0';
            s_WHEEL <= "00";
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 500 ms;
            
            s_WHEEL <= "10";
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 470 ms;
            
            s_RESET <= '1'; wait for 20 ms;
            s_RESET <= '0';
            s_wheel <= "11";
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 250 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 250 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 250 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 250 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 250 ms;
            
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 400 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 400 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 400 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 400 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 400 ms;
            
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            s_PROBE <= '1';wait for 10 ms;
            s_PROBE <= '0';wait for 490 ms;
            
            report "Stimulus process finished" severity note;
            wait;
        end process p_stimulus;
end Behavioral;
