----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 10:33:17
-- Design Name: 
-- Module Name: tb_hex_7seg - Behavioral
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

entity tb_hex_7seg is
--  Port ( );
end tb_hex_7seg;

architecture Behavioral of tb_hex_7seg is
 constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    
    -- Local signals
    signal s_clk_100MHz : std_logic;
    signal s_hexA       : unsigned(4 - 1 downto 0);
    signal s_hexB       : unsigned(4 - 1 downto 0);
    signal s_hexC       : unsigned(4 - 1 downto 0);
    signal s_hexD       : unsigned(4 - 1 downto 0);
    signal s_outA       : std_logic_vector(7 - 1 downto 0);
    signal s_outB       : std_logic_vector(7 - 1 downto 0);
    signal s_outC       : std_logic_vector(7 - 1 downto 0);
    signal s_outD       : std_logic_vector(7 - 1 downto 0);
    
 begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    hex7segA : entity work.hex7seg
        port map(
            hex_i => s_hexA,
            seg_o => s_outA       
        );
        
    hex7segB : entity work.hex7seg
        port map(
            hex_i => s_hexB,
            seg_o => s_outB       
        );
        
   hex7segC : entity work.hex7seg
        port map(
            hex_i => s_hexC,
            seg_o => s_outC       
        );
   hex7segD : entity work.hex7seg
        port map(
            hex_i => s_hexD,
            seg_o => s_outD       
        );
   
   --------------------------------------------------------------------
        -- Clock generation process
        --------------------------------------------------------------------
        p_clk_gen : process
        begin
            while now < 30 ms loop         
                s_clk_100MHz <= '0';
                wait for c_CLK_100MHZ_PERIOD / 2;
                s_clk_100MHz <= '1';
                wait for c_CLK_100MHZ_PERIOD / 2;
            end loop;
            wait;
        end process p_clk_gen;
             
  p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_hexA <= "0000";wait for 100 ns; --0
        s_hexB <= "0001";wait for 100 ns; --1
        s_hexC <= "0010";wait for 100 ns; --2
        s_hexD <= "0011";wait for 100 ns; --3
        s_hexA <= "0100";wait for 100 ns; --4
        s_hexB <= "0101";wait for 100 ns; --5
        s_hexC <= "0110";wait for 100 ns; --6
        s_hexD <= "0111";wait for 100 ns; --7
        s_hexA <= "1000";wait for 100 ns; --8
        s_hexB <= "1001";wait for 100 ns; --9
        s_hexC <= "1010";wait for 100 ns; --A
        s_hexD <= "1011";wait for 100 ns; --B
        s_hexA <= "1100";wait for 100 ns; --C
        s_hexB <= "1101";wait for 100 ns; --D
        s_hexC <= "1110";wait for 100 ns; --E
        s_hexD <= "1111";wait for 100 ns; --F

        report "Stimulus process finished" severity note;
        wait;
        

    end process p_stimulus;
end Behavioral;
