library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity console is
     port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        -- Traffic lights (RGB LEDs) for two directions
        line_one_o : out std_logic_vector(3 - 1 downto 0)
    );
end console;

architecture Behavioral of console is

begin


end Behavioral;
