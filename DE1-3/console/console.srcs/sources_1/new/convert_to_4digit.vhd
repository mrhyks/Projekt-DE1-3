----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2021 16:23:15
-- Design Name: 
-- Module Name: convert_to_4digit - Behavioral
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

entity convert_to_4digit is
    Port (
        clk     : in std_logic;
        i_SPD   : in unsigned(31 downto 0);        -- Speed output
        i_AVGS  : in unsigned(31 downto 0);        -- Average speed output
        i_DIST  : in unsigned(31 downto 0);        -- Travel distance output
        i_MODE  : in std_logic_vector(1 downto 0);
        o_D0    : out unsigned(3 downto 0);
        o_D1    : out unsigned(3 downto 0);
        o_D2    : out unsigned(3 downto 0);
        o_D3    : out unsigned(3 downto 0) 
    );
end convert_to_4digit;

architecture Behavioral of convert_to_4digit is
    signal s_helper : unsigned(31 downto 0);
    signal s_D0 : unsigned(3 downto 0);
    signal s_D1 : unsigned(3 downto 0);
    signal s_D2 : unsigned(3 downto 0);
    signal s_D3 : unsigned(3 downto 0);
begin
    p_convert:process(clk)
    begin
        s_D0<="0000";
        s_D1<="0000";
        s_D2<="0000";
        s_D3<="0000";
        
        if(i_MODE="01")then
            s_helper<=i_SPD;
            while s_helper>0 loop
                if(s_helper>1000)then
                    s_helper<=s_helper-"00000000000000000000001111101000";
                    s_D3<=s_D3+1;   
                elsif(s_helper>100)then
                    s_helper<=s_helper-100; 
                    s_D2<=s_D2+1;
                elsif(s_helper>10)then
                    s_helper<=s_helper-10; 
                    s_D1<=s_D1+1;
                elsif(s_helper>1)then
                    s_helper<=s_helper-1;
                    s_D0<=s_D0+1; 
                end if;
            end loop;
            o_D0<=s_D0; 
            o_D1<=s_D1; 
            o_D2<=s_D2; 
            o_D3<=s_D3;    
         elsif(i_MODE="10")then
            s_helper<=i_AVGS;
            while s_helper>0 loop
                if(s_helper>=1000)then
                    s_helper<=s_helper-1000;
                    s_D3<=s_D3+1;   
                elsif(s_helper>=100)then
                    s_helper<=s_helper-100; 
                    s_D2<=s_D2+1;
                elsif(s_helper>=10)then
                    s_helper<=s_helper-10; 
                    s_D1<=s_D1+1;
                elsif(s_helper>=1)then
                    s_helper<=s_helper-1;
                    s_D0<=s_D0+1; 
                end if;
            end loop; 
            o_D0<=s_D0; 
            o_D1<=s_D1; 
            o_D2<=s_D2; 
            o_D3<=s_D3; 
         elsif(i_MODE="11")then
            s_helper<=i_DIST;
            while s_helper>0 loop
                if(s_helper>=1000)then
                    s_helper<=s_helper-1000;
                    s_D3<=s_D3+1;   
                elsif(s_helper>=100)then
                    s_helper<=s_helper-100; 
                    s_D2<=s_D2+1;
                elsif(s_helper>=10)then
                    s_helper<=s_helper-10; 
                    s_D1<=s_D1+1;
                elsif(s_helper>=1)then
                    s_helper<=s_helper-1;
                    s_D0<=s_D0+1; 
                end if;
            end loop; 
            o_D0<=s_D0; 
            o_D1<=s_D1; 
            o_D2<=s_D2; 
            o_D3<=s_D3;     
         end if;    
    end process p_convert;
end Behavioral;
