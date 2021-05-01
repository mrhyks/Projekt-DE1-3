-----------------------------------------------------------------
-- This is testbench for average.vhd
-----------------------------------------------------------------

library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_average is
--  Port ( );
end tb_average;

architecture Behavioral of tb_average is
    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ms;
    
    --Local signals
    signal s_clk_100MHz   : std_logic;
    signal s_reset        : std_logic;
    signal s_wheel        : std_logic_vector(1 downto 0);
    signal s_sonda        : std_logic;
    signal s_mode         : std_logic_vector(1 downto 0);
    signal s_avg_speed    : unsigned(31 downto 0);
begin
     uut_distance : entity work.average
        port map(
            clk         => s_clk_100MHz,
            reset       => s_reset,
            i_wheel     => s_wheel,
            i_sonda     => s_sonda,
            i_mode      => s_mode,
            o_avg_speed => s_avg_speed
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

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0'; wait for 2890 ms;
        -- Reset activated
        s_reset <= '1'; wait for 100 ms;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;
    
    ----------------------------------------------------------------------
    -- Artificial generator for mode signal 
    ----------------------------------------------------------------------
    p_mode_gen : process
    begin
        s_mode <= "10"; wait for 4000 ms;
        
        s_mode <= "00"; wait for 2000 ms;
        
        s_mode <= "01"; wait for 2000 ms;
        
        s_mode <= "11"; wait for 2000 ms;
        
        s_mode <= "00";
        wait;
    end process p_mode_gen;
    
    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        
        s_wheel<="01";
        wait for 5ms;
        s_sonda<='0';wait for 300ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 300ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 300ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 300ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 300ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 300ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 300ms;
        
        
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 350ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 350ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 350ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 350ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 350ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 350ms;
        
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        s_sonda<='1';wait for 10ms;
        s_sonda<='0';wait for 700ms;
        wait;
    end process p_stimulus;

end Behavioral;
