-----------------------------------------------------------------
-- This is module for reset.vhd
-----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reset is
    Port (
        i_button0_reset : in  std_logic;    -- Reset input from mode.vhd
        i_button1_reset : in  std_logic;    -- Reset input from wheel.vhd
        
        o_reset         : out std_logic     -- Reset output
    );
end reset;

architecture Behavioral of reset is
    
begin
    ------------------------------------------------------------
    -- Process for reset (o_reset) signal output
    -- When reset signals from mode.vhd and wheel.vhd are '1'
    -- it will initiate reset for distance and average speed
    ------------------------------------------------------------
    p_reset : process(i_button0_reset,i_button1_reset)
    begin
        if ((rising_edge(i_button0_reset) and i_button1_reset = '1') or (rising_edge(i_button1_reset) and i_button0_reset = '1')) then
            o_reset <= '1';
        else 
            o_reset <= '0';
        end if; 
    end process p_reset;
end Behavioral;
