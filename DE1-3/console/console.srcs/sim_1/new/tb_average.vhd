library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith;

entity tb_average is
--  Port ( );
end tb_average;

architecture Behavioral of tb_average is
    -- Local constants
    --signal distance: integer range 0 to 32;
    constant c_MAX               : natural := 8;
    constant c_CLK_100MHZ_PERIOD : time := 10 ms;
    
    
    --Local signals
    signal s_clk_100MHz   : std_logic;
    signal s_reset        : std_logic;
    signal s_wheel        : std_logic_vector(1 downto 0);
    signal s_sonda        : std_logic;
    signal s_bin_avg_speed: unsigned(31 downto 0);
    signal s_bin_time : unsigned(15 downto 0);
    signal s_bin_distance : unsigned(31 downto 0);
begin
     uut_distance : entity work.average
        generic map(
            g_MAX => c_MAX
        )   -- Note that there is NO comma or semicolon between
            -- generic map section and port map section
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            wheel   => s_wheel,
            sonda   => s_sonda,
            o_bin_avg_speed=>s_bin_avg_speed,
            o_bin_time=>s_bin_time,
            o_bin_distance=>s_bin_distance
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
        s_reset <= '0'; wait for 200 ns;
        -- Reset activated
        s_reset <= '1'; wait for 500 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;

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
