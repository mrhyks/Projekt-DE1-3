
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith;

entity distance is
    generic(
    constant Pi : real:=3.14159
    
    );
    Port (
        clk      : in  std_logic;       -- Main clock
        reset    : in  std_logic;       -- Synchronous reset
        sonda    : in std_logic;
        wheel    : in std_logic_vector(1 downto 0)
        --distance: integer range 0 to 32
        --en_i     : in  std_logic;       -- Enable input
        --cnt_up_i : in  std_logic;       -- Direction of the counter
        --cnt_o    : out std_logic_vector(g_CNT_WIDTH - 1 downto 0)
   );
end distance;

architecture Behavioral of distance is
    --type t_wheel is (I26, I27, I28, I29);
    --signal rotations : integer range 0 to 32;
    signal rotations : integer range 0 to 32;
    signal distance: integer range 0 to 32;
    --signal s_wheel  : t_wheel;
begin
    p_distance : process(clk)
    begin
        if rising_edge(clk) then
            if (sonda='1') then
                case wheel is
                    when "00" =>
                        distance<=rotations*207,5;
                    when "01" =>
                        distance<=rotations*215,5;
                    when "10" =>
                        distance<=rotations*223,4;  
                    when others =>
                        distance<=rotations*231,4;
                end case;
                rotations<=rotations+1; 
            end if;
        end if;
    end process p_distance;
end Behavioral;
