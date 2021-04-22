library ieee;
use ieee.std_logic_1164.all;

entity tb_distance is
end entity tb_distance;

architecture testbench of tb_distance is
    -- Local constants
    --signal distance: integer range 0 to 32;
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_wheel      : std_logic_vector(1 downto 0);
    signal s_sonda      : std_logic;
    signal s_distance   : integer range 0 to 32;
    signal s_rotations  : integer range 0 to 32;

begin
    -- Connecting testbench signals with tlc entity (Unit Under Test)
    uut_distance : entity work.distance
        generic map(
            distance=> s_distance,
            rotations=>s_rotations
        )
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            wheel   => s_wheel,
            sonda   => s_sonda
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 10000 ns loop   -- 10 usec of simulation
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
        s_sonda<='0';wait for 100ms;
        s_sonda<='1';wait for 100ms;
        s_sonda<='0';wait for 100ms;
        s_sonda<='1';wait for 100ms;
        s_sonda<='0';wait for 100ms;
        s_sonda<='1';wait for 100ms;
        s_sonda<='0';wait for 100ms;
        s_sonda<='1';wait for 100ms;
        s_sonda<='0';wait for 100ms;
        s_sonda<='1';wait for 100ms;
        s_sonda<='0';wait for 100ms;
        s_sonda<='1';wait for 100ms;
        s_sonda<='0';wait for 100ms;
        
        
        wait;
    end process p_stimulus;

end architecture testbench;
