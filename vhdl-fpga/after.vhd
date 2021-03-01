


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity affter is
    Port ( ovr : in STD_LOGIC;
           I : in STD_LOGIC_vector(3 downto 0);
           s2 : in STD_LOGIC;
           dispout: out STD_LOGIC_vector(13 downto 0));
end affter;

architecture Behavioral of affter is
 signal Ineg, midout: std_logic_vector(3 downto 0);
 signal muxsel : std_logic_vector(1 downto 0);
 signal m0,secfour: std_logic_vector(6 downto 0);
 
begin
muxsel <= s2 & ovr;
    
Ineg(0) <= I(0);     
Ineg(1) <= I(0) xor I(1);   
Ineg(2) <= I(2) xor (I(0) or I(1));
Ineg(3) <= I(3) xor (I(0) or I(1) or I(2));
        
IMUX:process(I,Ineg) 
    begin
        case I(3) is
            when '0' => midout <= I; secfour <= "0000001";
            when others => midout <= Ineg; secfour <= "1111110";
        end case; 
    end process;

decoder: process(midout)    
        begin
            case midout is
            when x"0" => m0 <= "0000001";--a-g
            when x"1" => m0 <= "1001111";
            when x"2" => m0 <= "0010010";
            when x"3" => m0 <= "0000110";
            when x"4" => m0 <= "1001100";
            when x"5" => m0 <= "0100100";
            when x"6" => m0 <= "0100000";
            when x"7" => m0 <= "0001111";
            when others => m0 <= "0000000";            
             end case;
        end process;

fmux: process(muxsel, secfour,m0)   
    begin 
       case muxsel is
        when "00" => 
            dispout <= secfour & m0;   
        when "01" => 
            dispout <= "01100000110000";
        when "10" => 
            dispout <= "11100011110001";
        when others => 
            dispout <= "11100011110001";   
        end case;    
    end process;
    
end Behavioral;
