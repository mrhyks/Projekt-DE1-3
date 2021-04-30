
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith;

entity speed is
    generic(
        g_MAX : natural := 10       -- Number of clk pulses to generate
                                    -- one enable signal period
    );
    Port (
        clk      : in  std_logic;       -- Main clock
        reset    : in  std_logic;       -- Synchronous reset
        sonda    : in std_logic;
        wheel    : in std_logic_vector(1 downto 0);
        o_speed : out integer range 0 to 32;
        o_bin_speed:out unsigned(15 downto 0);
        o_bin_time:out unsigned(15 downto 0)
   );
end speed;

architecture Behavioral of speed is
    signal speed : integer range 0 to 32:=0;
    signal bin_speed: unsigned(15 downto 0):="0000000000000000";
    signal bin_time: unsigned(15 downto 0):="0000000000000000";
begin
    p_speed : process(clk)
        variable v_TIME:time:=0ns;
    begin
        if rising_edge(clk) then
            if rising_edge(sonda) then                 
                case wheel is
                    when "00" =>
                        bin_speed<=7488/bin_time;
                    when "01" =>
                        bin_speed<=7776/bin_time;
                    when "10" =>
                        bin_speed<=8028/bin_time;
                    when others =>
                        bin_speed<=8316/bin_time;
                end case; 
            end if;
        elsif sonda='1' then
            if falling_edge(clk) then
                    bin_time<="0000000000000000";
            end if;  
        elsif falling_edge(clk) then
            bin_time<=bin_time+10;
            if bin_time>2000 then    
                bin_speed<="0000000000000000";
            end if;     
        end if;
    end process p_speed;
    o_bin_speed<=bin_speed(15 downto 0);
    o_bin_time<=bin_time;
end Behavioral;
