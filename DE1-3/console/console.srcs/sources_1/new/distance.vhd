
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith;

entity distance is
    generic(
        g_MAX : natural := 10       -- Number of clk pulses to generate
                                    -- one enable signal period
    );
    Port (
        clk      : in  std_logic;       -- Main clock
        reset    : in  std_logic;       -- Synchronous reset
        sonda    : in std_logic;
        wheel    : in std_logic_vector(1 downto 0);
        --rotations: inout std_logic_vector(15 downto 0);
        o_rotations : out integer range 0 to 32;
        o_distance: out integer range 0 to 32;
        o_bin_rotations:out unsigned(15 downto 0);
        o_bin_distance:out unsigned(15 downto 0)
        --distance: integer range 0 to 32
        --en_i     : in  std_logic;       -- Enable input
        --cnt_up_i : in  std_logic;       -- Direction of the counter
        --cnt_o    : out std_logic_vector(g_CNT_WIDTH - 1 downto 0)
   );
end distance;

architecture Behavioral of distance is
    --type t_wheel is (I26, I27, I28, I29);
    --signal rotations : integer range 0 to 32;
    signal rotations : integer range 0 to 32:=0;
    signal distance: integer range 0 to 32:=0;
    signal bin_rotations: unsigned(15 downto 0):="0000000000000000";
    signal bin_distance: unsigned(15 downto 0):="0000000000000000";
    --signal s_wheel  : t_wheel;
begin
    p_distance : process(clk)
    begin
        if rising_edge(clk) then
            if rising_edge(sonda) then
                rotations<=rotations+1;
                bin_rotations<=bin_rotations+1;
                case wheel is
                    when "00" =>
                        distance<=distance+208;
                        bin_distance<=bin_distance +208;
                    when "01" =>
                        distance<=distance+216;
                        bin_distance<=bin_distance + 216;
                    when "10" =>
                        distance<=distance+223; 
                        bin_distance<=bin_distance +223; 
                    when others =>
                        distance<=distance+231;
                        bin_distance<=bin_distance + 231;
                end case; 
            end if;
            --rotations<=rotations+1;
            --bin_rotations<=bin_rotations+'1';
        end if;
    end process p_distance;
    o_rotations<=rotations;
    o_distance<=distance;
    o_bin_rotations<=bin_rotations(15 downto 0);
    o_bin_distance<=bin_distance(15 downto 0);
end Behavioral;
