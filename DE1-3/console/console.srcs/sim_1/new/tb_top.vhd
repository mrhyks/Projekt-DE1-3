-----------------------------------------------------------------
-- This is testbench for top.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top is
end tb_top;

architecture Behavioral of tb_top is
    -- Local constant
    constant c_CLK_100MHZ_PERIOD : time := 10 ms;
    
    -- Local signals
    signal s_clk_100MHz : std_logic;
    signal s_btn0       : std_logic;
    signal s_btn1       : std_logic;
    signal sensor       : std_logic;
    signal s_speed      : unsigned(31 downto 0);
    signal s_avg_speed  : unsigned(31 downto 0);
    signal s_distance   : unsigned(31 downto 0);
begin
    uut_top : entity work.top
        port map(
            btn(0)      => s_btn0,
            btn(1)      => s_btn1,
            CLK100MHZ   => s_clk_100MHz,
            ck_io4      => sensor,
            SPEED       => s_speed,
            AVG_SPEED   => s_avg_speed,
            DISTANCE    => s_distance
        );
        
        --------------------------------------------------------------------
        -- Clock generation process
        --------------------------------------------------------------------
        p_clk_gen : process
        begin
            while now < 30000 ms loop         
                s_clk_100MHz <= '0';
                wait for c_CLK_100MHZ_PERIOD / 2;
                s_clk_100MHz <= '1';
                wait for c_CLK_100MHZ_PERIOD / 2;
            end loop;
            wait;
        end process p_clk_gen;
        
        --------------------------------------------------------------------
        -- Artificial sensor signal generator 
        --------------------------------------------------------------------
        p_sensor_gen : process
        begin
            while now < 30000 ms loop
                sensor <= '0'; wait for 490 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 500 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 490 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 600 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 673 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 740 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 695 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 698 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 430 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 450 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 486 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 489 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 491 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 475 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 400 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 426 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 497 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 546 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 789 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 756 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 853 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 896 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 874 ms;
                sensor <= '1'; wait for 10 ms;
                sensor <= '0'; wait for 800 ms;
            end loop;
            wait;
        end process p_sensor_gen;
        
        ----------------------------------------------------------------------
        -- Data generation process 
        ---------------------------------------------------------------------- 
        p_stimulus : process
        begin
            -- Report a note at the begining of stimulus process
            report "Stimulus process started" severity note;
                s_btn0 <= '0';
                s_btn1 <= '0'; wait for 100 ms;
                
                -- Selecting Mode - "00" - Wheel mode selection (0)
                s_btn0 <= '1'; wait for 15 ms;
                s_btn0 <= '0';
                
                -- Selecting Wheel - "10" (2)
                s_btn1 <= '1'; wait for 15 ms;
                s_btn1 <= '0'; wait for 340 ms;
                s_btn1 <= '1'; wait for 15 ms;
                s_btn1 <= '0'; wait for 320 ms;
                s_btn1 <= '1'; wait for 15 ms;
                s_btn1 <= '0'; wait for 360 ms;
                
                -- Selecting Mode - "01" - Speed display (1)
                s_btn0 <= '1'; wait for 15 ms;
                s_btn0 <= '0'; wait for 3000 ms;
                
                -- Selecting Mode - "10" - Average speed display (2)
                s_btn0 <= '1'; wait for 15 ms;
                s_btn0 <= '0'; wait for 9000 ms;
                
                -- Selecting Mode - "11" - Travel distance display (3)
                s_btn0 <= '1'; wait for 15 ms;
                s_btn0 <= '0'; wait for 4000 ms;
                
                -- Selecting Mode - "00" - Wheel mode selection (0)
                s_btn0 <= '1'; wait for 15 ms;
                s_btn0 <= '0'; wait for 100 ms;
                
                -- Selecting Wheel - "00" (0)
                s_btn1 <= '1'; wait for 15 ms;
                s_btn1 <= '0'; wait for 260 ms;
                s_btn1 <= '1'; wait for 15 ms;
                s_btn1 <= '0'; wait for 150 ms;
                
                -- Selecting Mode - "01" - Speed display (1)
                s_btn0 <= '1'; wait for 15 ms;
                s_btn0 <= '0'; wait for 1500 ms;
                
                -- Reset, Display mode will be "10" (2)
                s_btn0 <= '1'; wait for 10 ms;
                s_btn1 <= '1'; wait for 2100 ms;
                s_btn0 <= '0'; 
                s_btn1 <= '0'; wait for 800 ms;
                
                -- Selecting Mode - "11" - Travel distance display (3)
                s_btn0 <= '1'; wait for 15 ms;
                s_btn0 <= '0'; wait for 4000 ms;
                
            report "Stimulus process finished" severity note;
            wait;
        end process p_stimulus;
end Behavioral;
