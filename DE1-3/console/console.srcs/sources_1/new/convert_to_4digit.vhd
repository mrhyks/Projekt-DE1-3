library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity convert_to_4digit is
    Port (
        clk     : in std_logic;
        i_SPD   : in unsigned(31 downto 0);        -- Speed output
        i_AVGS  : in unsigned(31 downto 0);        -- Average speed output
        i_DIST  : in unsigned(31 downto 0);        -- Travel distance output
        i_sensor: in std_logic;
        i_MODE  : in std_logic_vector(1 downto 0);
        o_D0    : out unsigned(3 downto 0);
        o_D1    : out unsigned(3 downto 0);
        o_D2    : out unsigned(3 downto 0);
        o_D3    : out unsigned(3 downto 0)
    );
end convert_to_4digit;

architecture Behavioral of convert_to_4digit is
    signal s_helper : unsigned(31 downto 0);
    signal s_D0     : unsigned(3 downto 0);
    signal s_D1     : unsigned(3 downto 0);
    signal s_D2     : unsigned(3 downto 0);
    signal s_D3     : unsigned(3 downto 0);
begin
    
    p_convert:process(clk)
    begin  
        if i_sensor = '1' then                  --If wheel spins, set LSB of helper counter to Undefined
            s_helper(0) <= 'U';  
        end if;
        
        if(i_MODE="01")then                     --If mode is set to display SPEED continue
        
            if s_helper(0) = 'U' then           --If LSB of helper counter is undefined, set value of helper to SPEED
                s_helper <= i_SPD;              
                s_D0 <="0001";                  --Set initial values of digits to 0
                s_D1 <="0000";
                s_D2 <="0000";
                s_D3 <="0000";
                
            elsif s_helper>0 then               
                if(s_helper>=1000)then          --Lower helper counter depending on its size
                    s_helper<=s_helper-1000;    --If helper counter is bigger then 1000, lower its values by 1000
                    s_D3<=s_D3+1;               --Increase value of biggest digit by 1
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
                
                o_D0<=s_D0;                     --output inner signals
                o_D1<=s_D1; 
                o_D2<=s_D2; 
                o_D3<=s_D3; 
            end if;
               
         elsif(i_MODE="10")then                 --If mode is set to display AVG SPEED continue
         
            if s_helper(0) = 'U' then
                s_helper<=i_AVGS;
                s_D0 <="0001";
                s_D1 <="0000";
                s_D2 <="0000";
                s_D3 <="0000";
                
            elsif s_helper>0 then 
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
                
                o_D0<=s_D0; 
                o_D1<=s_D1; 
                o_D2<=s_D2; 
                o_D3<=s_D3; 
            end if;
            
         elsif(i_MODE="11")then                  --If mode is set to display DISTANCE continue
         
            if s_helper(0) = 'U' then
                s_helper<=i_DIST;
                s_D0 <="0001";
                s_D1 <="0000";
                s_D2 <="0000";
                s_D3 <="0000";
                
            elsif s_helper>0 then 
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
                
                o_D0<=s_D0; 
                o_D1<=s_D1; 
                o_D2<=s_D2; 
                o_D3<=s_D3; 
            end if;
        end if;
    end process p_convert;
end Behavioral;