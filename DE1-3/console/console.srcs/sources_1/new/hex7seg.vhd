library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity hex7seg is
    Port (
        hex0_i       : in  unsigned (4 - 1 downto 0);
        hex1_i       : in  unsigned (4 - 1 downto 0);
        hex2_i       : in  unsigned (4 - 1 downto 0);
        hex3_i       : in  unsigned (4 - 1 downto 0);
        
        seg0_o 	     : out std_logic_vector (7 - 1 downto 0);
        seg1_o 	     : out std_logic_vector (7 - 1 downto 0);
        seg2_o 	     : out std_logic_vector (7 - 1 downto 0);
        seg3_o 	     : out std_logic_vector (7 - 1 downto 0)
    );
end hex7seg;

architecture Behavioral of hex7seg is
begin
    --------------------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display decoder. 
    -- Any time "hex_i" is changed, the process is "executed".
    -- Output pin seg_o(6) corresponds to segment A, seg_o(5) to B, etc.
    --------------------------------------------------------------------
    

    p_7seg3_decoder : process(hex3_i)
    begin
        case hex3_i is
            when "0000" =>
                seg3_o <= "0000001";     -- 0
            when "0001" =>
                seg3_o <= "1001111";     -- 1
            when "0010" =>
                seg3_o <= "0010010";     -- 2
            when "0011" =>
                seg3_o <= "0000110";     -- 3
            when "0100" =>
                seg3_o <= "0001100";     -- 4
            when "0101" =>
                seg3_o <= "0100100";     -- 5
            when "0110" =>
                seg3_o <= "0100000";     -- 6
            when "0111" =>
                seg3_o <= "0001111";     -- 7
            when "1000" =>
                seg3_o <= "0000000";     -- 8
            when "1001" =>
                seg3_o <= "0000100";     -- 9
            when "1010" =>
                seg3_o <= "0001000";     -- A
            when "1011" =>
                seg3_o <= "1100000";     -- B
            when "1100" =>
                seg3_o <= "0110001";     -- C
            when "1101" =>
                seg3_o <= "1000010";     -- D
            when "1110" =>
                seg3_o <= "0110000";     -- E
            when others =>
                seg3_o <= "0111000";     -- F
        end case;
    end process p_7seg3_decoder;
        
    p_7seg2_decoder : process(hex2_i)
    begin
        case hex2_i is
            when "0000" =>
                seg2_o <= "0000001";     -- 0
            when "0001" =>
                seg2_o <= "1001111";     -- 1
            when "0010" =>
                seg2_o <= "0010010";     -- 2
            when "0011" =>
                seg2_o <= "0000110";     -- 3
            when "0100" =>
                seg2_o <= "0001100";     -- 4
            when "0101" =>
                seg2_o <= "0100100";     -- 5
            when "0110" =>
                seg2_o <= "0100000";     -- 6
            when "0111" =>
                seg2_o <= "0001111";     -- 7
            when "1000" =>
                seg2_o <= "0000000";     -- 8
            when "1001" =>
                seg2_o <= "0000100";     -- 9
            when "1010" =>
                seg2_o <= "0001000";     -- A
            when "1011" =>
                seg2_o <= "1100000";     -- B
            when "1100" =>
                seg2_o <= "0110001";     -- C
            when "1101" =>
                seg2_o <= "1000010";     -- D
            when "1110" =>
                seg2_o <= "0110000";     -- E
            when others =>
                seg2_o <= "0111000";     -- F
        end case;
    end process p_7seg2_decoder;
        
    p_7seg1_decoder : process(hex1_i)
    begin
        case hex1_i is
            when "0000" =>
                seg1_o <= "0000001";     -- 0
            when "0001" =>
                seg1_o <= "1001111";     -- 1
            when "0010" =>
                seg1_o <= "0010010";     -- 2
            when "0011" =>
                seg1_o <= "0000110";     -- 3
            when "0100" =>
                seg1_o <= "0001100";     -- 4
            when "0101" =>
                seg1_o <= "0100100";     -- 5
            when "0110" =>
                seg1_o <= "0100000";     -- 6
            when "0111" =>
                seg1_o <= "0001111";     -- 7
            when "1000" =>
                seg1_o <= "0000000";     -- 8
            when "1001" =>
                seg1_o <= "0000100";     -- 9
            when "1010" =>
                seg1_o <= "0001000";     -- A
            when "1011" =>
                seg1_o <= "1100000";     -- B
            when "1100" =>
                seg1_o <= "0110001";     -- C
            when "1101" =>
                seg1_o <= "1000010";     -- D
            when "1110" =>
                seg1_o <= "0110000";     -- E
            when others =>
                seg1_o <= "0111000";     -- F
        end case;
    end process p_7seg1_decoder;
        
    p_7seg0_decoder : process(hex0_i)
    begin
        case hex0_i is
            when "0000" =>
                seg0_o <= "0000001";     -- 0
            when "0001" =>
                seg0_o <= "1001111";     -- 1
            when "0010" =>
                seg0_o <= "0010010";     -- 2
            when "0011" =>
                seg0_o <= "0000110";     -- 3
            when "0100" =>
                seg0_o <= "0001100";     -- 4
            when "0101" =>
                seg0_o <= "0100100";     -- 5
            when "0110" =>
                seg0_o <= "0100000";     -- 6
            when "0111" =>
                seg0_o <= "0001111";     -- 7
            when "1000" =>
                seg0_o <= "0000000";     -- 8
            when "1001" =>
                seg0_o <= "0000100";     -- 9
            when "1010" =>
                seg0_o <= "0001000";     -- A
            when "1011" =>
                seg0_o <= "1100000";     -- B
            when "1100" =>
                seg0_o <= "0110001";     -- C
            when "1101" =>
                seg0_o <= "1000010";     -- D
            when "1110" =>
                seg0_o <= "0110000";     -- E
            when others =>
                seg0_o <= "0111000";     -- F
        end case;
    end process p_7seg0_decoder;

end Behavioral;
