----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2021 17:03:30
-- Design Name: 
-- Module Name: tb_convert_to_4digit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_convert_to_4digit is
--  Port ( );
end tb_convert_to_4digit;

architecture Behavioral of tb_convert_to_4digit is
    signal s_clk_100MHz          : std_logic;                   -- clk signal
    signal s_RESET               : std_logic;
    
    signal s_MODE                : std_logic_vector(1 downto 0);
    signal s_SPD                 : unsigned(31 downto 0);
    signal s_AVGS                : unsigned(31 downto 0);
    signal s_DIST                : unsigned(31 downto 0);
    
    constant c_CLK_100MHZ_PERIOD : time := 10 ms;
begin
    uut_convert_to_4digit : entity work.convert_to_4digit
        port map(
            clk     => s_clk_100MHz,
            i_MODE  => s_MODE,
            i_SPD   => s_SPD,
            i_AVGS  => s_AVGS,
            i_DIST  => s_DIST
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
        
        ----------------------------------------------------------------------
        -- Artificial generator for mode signal 
        ----------------------------------------------------------------------
        p_mode_gen : process
        begin
            s_MODE <= "01"; wait for 500 ms;
            s_SPD<="00000000000000000000100111101110";
            s_MODE <= "01"; wait for 1500 ms;
            s_SPD<="00000000000000000000100111101110";
            s_MODE <= "10"; wait for 1500 ms;
            s_AVGS<="00000000000000000000010100000000";
            s_MODE <= "11"; wait for 1500 ms;
            s_DIST<="00000000000000000000010010110000";
            
            s_MODE <= "00"; 
            wait;
        end process p_mode_gen;

end Behavioral;
