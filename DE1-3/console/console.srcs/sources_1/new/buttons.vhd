-----------------------------------------------------------------
-- This is top design for wheel.vhd, mode.vhd and reset.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buttons is
    Port ( 
        i_BTN0  : in  std_logic;                    -- Button input
        i_BTN1  : in  std_logic;                    -- Button input
        clk     : in  std_logic;                    -- Clock Input
        
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
    signal btn0_reset : std_logic;                   -- Reset signal
    signal btn1_reset : std_logic;                   -- Reset signal
    signal modes      : std_logic_vector(1 downto 0);-- mode signal
      
begin    
    --------------------------------------------------------------------
    -- Instance (copy) of wheel entity
    wheel : entity work.wheel
        port map(
            clk             => clk,
            i_button0       => i_BTN0,
            i_button1       => i_BTN1,
            i_mode          => modes,
            o_button1_reset => btn1_reset,
            o_wheel         => o_WHEEL
        );
    
    --------------------------------------------------------------------
    -- Instance (copy) of mode entity
    mode : entity work.mode
        port map(
            clk             => clk,
            i_button0       => i_BTN0,
            i_button1       => i_BTN1,
            o_mode          => modes,
            o_button0_reset => btn0_reset
        );
        
    --------------------------------------------------------------------
    -- Instance (copy) of reset entity
    reset : entity work.reset
        port map(
            i_button0_reset => btn0_reset,
            i_button1_reset => btn1_reset,
            o_reset         => o_RESET
        );
        
    o_MODE <= modes;    -- mode ouput
end Behavioral;
