
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith;

entity average is
    generic(
        g_MAX : natural := 10       -- Number of clk pulses to generate
                                    -- one enable signal period
    );
    Port (
        clk      : in  std_logic;       -- Main clock
        reset    : in  std_logic;       -- Synchronous reset
        sonda    : in std_logic;
        wheel    : in std_logic_vector(1 downto 0);
        o_avg_speed : out integer range 0 to 32;
        o_bin_avg_speed:out unsigned(31 downto 0);
        o_bin_time:out unsigned(15 downto 0);
        o_bin_distance:out unsigned(31 downto 0)
   );
end average;

architecture Behavioral of average is
    signal speed : integer range 0 to 32:=0;
    signal bin_avg_speed: unsigned(31 downto 0):="00000000000000000000000000000000";
    signal bin_time: unsigned(15 downto 0):="0000000000000000";
    signal bin_distance: unsigned(31 downto 0):="00000000000000000000000000000000";
begin
    p_average : process(clk)
        variable v_TIME:time:=0ns;
    begin
        if rising_edge(clk) then
            if rising_edge(sonda) then                                
                case wheel is
                    when "00" =>
                        bin_distance<=bin_distance + 7488;                  
                    when "01" =>
                        bin_distance<=bin_distance + 7776;
                    when "10" =>
                        bin_distance<=bin_distance + 8028; 
                    when others =>
                        bin_distance<=bin_distance + 8316;
                end case;
                if(not(bin_time=0) AND not(bin_distance=0)) then
                    bin_avg_speed<=bin_distance/bin_time;
                end if;
            end if;
        elsif (falling_edge(clk) AND not(bin_distance = 0))then
            bin_time<=bin_time+10;
        end if;
    end process p_average;
    o_bin_avg_speed<=bin_avg_speed;
    o_bin_time<=bin_time;
    o_bin_distance<=bin_distance;
end Behavioral;
