-----------------------------------------------------------------
-- This is top design for wheel.vhd, mode.vhd and reset.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buttons is
    Port ( 
        i_BTN0  : in  std_logic;                    -- Button input
        i_BTN1  : in  std_logic;                    -- Button input
        
        o_RESET : out std_logic;                    -- Reset output
        o_MODE  : out std_logic_vector(1 downto 0); -- Mode output
        o_WHEEL : out std_logic_vector(1 downto 0)  -- Wheel output
    );
end buttons;

------------------------------------------------------------------------
-- Architecture body
------------------------------------------------------------------------
architecture Behavioral of buttons is
    -- Local signals
    signal btn1_reset            : std_logic;                   -- Reset signal
    signal btn2_reset            : std_logic;                   -- Reset signal
    signal modes                 : std_logic_vector(1 downto 0);-- mode signal
    signal s_clk_100MHz          : std_logic;                   -- clk signal
    
    -- Local constant; Period 500 ms for countdowns in mode and wheel
    constant c_CLK_100MHZ_PERIOD : time := 500 ms;  
begin
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
    -- Instance (copy) of wheel entity
    wheel : entity work.wheel
        port map(
            clk => s_clk_100MHz,
            i_button1 => i_BTN0,
            i_button2 => i_BTN1,
            i_mode => modes,
            o_button2_reset => btn2_reset,
            o_wheel => o_WHEEL
        );
    
    --------------------------------------------------------------------
    -- Instance (copy) of mode entity
    mode : entity work.mode
        port map(
            clk => s_clk_100MHz,
            i_button1 => i_BTN0,
            i_button2 => i_BTN1,
            o_mode => modes,
            o_button1_reset => btn1_reset
        );
        
    --------------------------------------------------------------------
    -- Instance (copy) of reset entity
    reset : entity work.reset
        port map(
            i_button1_reset => btn1_reset,
            i_button2_reset => btn2_reset,
            o_reset => o_RESET
        );
        
    o_MODE <= modes;
end Behavioral;
