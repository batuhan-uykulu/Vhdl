library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registers is
    Port ( 
           done     : in  STD_LOGIC;
           opcode   : out  std_logic_vector(15 downto 0);
          -- finished : out  STD_LOGIC;
           advanced : out std_logic);
end registers;

architecture Behavioral of registers is
	signal address : unsigned(7 downto 0) := (others => '0');
begin
    process(done)
    begin
        advanced <= '0';
        if rising_edge(done) then  
            if address <= x"37" then
                address <= address +1;
                advanced <= '1';
              --  finished <= '0';
             else
              --  finished <= '1';
                advanced <= '0';   
            end if;    
        end if;
    end process;
    process (address) is begin	     
       case address is
				when x"00" => opcode <= x"1280"; 
				when x"01" => opcode <= x"1280"; 
				when x"02" => opcode <= x"1204"; 
				when x"03" => opcode <= x"1100"; -- CLKRC  Prescaler - Fin/(1+1)(s)
				when x"04" => opcode <= x"0C00"; 
				when x"05" => opcode <= x"3E00"; -- COM14  PCLK scaling off(s)
			    when x"06" => opcode <= x"8C02"; -- RGB444 Set RGB format (susp)
   			    when x"07" => opcode <= x"0400"; 
 				when x"08" => opcode <= x"4000"; -- COM15  Full 0-255 output, RGB 565 (ok) 
				when x"09" => opcode <= x"3a04"; 
				when x"0A" => opcode <= x"1438"; 
				when x"0B" => opcode <= x"4fb3"; 
				when x"0C" => opcode <= x"50b3"; 
				when x"0D" => opcode <= x"5100"; 
				when x"0E" => opcode <= x"523d"; 
				when x"0F" => opcode <= x"53a7"; 
				when x"10" => opcode <= x"54e4"; 
				when x"11" => opcode <= x"589e"; 
				when x"12" => opcode <= x"3dc0"; 
				when x"13" => opcode <= x"1100"; -- CLKRC  Prescaler - Fin/(1+1)(s)
				
				when x"14" => opcode <= x"1711"; -- HSTART HREF start (high 8 bits)
				when x"15" => opcode <= x"1861"; -- HSTOP  HREF stop (high 8 bits)
				when x"16" => opcode <= x"32A4"; -- HREF   Edge offset and low 3 bits of HSTART and HSTOP
				
				when x"17" => opcode <= x"1903"; -- VSTART VSYNC start (high 8 bits)
				when x"18" => opcode <= x"1A7b"; -- VSTOP  VSYNC stop (high 8 bits) 
				when x"19" => opcode <= x"030a"; -- VREF   VSYNC low two bits
         
            when x"1A" => opcode <= x"0e61"; -- COM5(0x0E) 0x61
            when x"1B" => opcode <= x"0f4b"; -- COM6(0x0F) 0x4B 
            
            when x"1C" => opcode <= x"1602"; --
            when x"1D" => opcode <= x"1e37"; -- MVFP (0x1E) 0x07  -- FLIP AND MIRROR IMAGE 0x3x

            when x"1E" => opcode <= x"2102";
            when x"1F" => opcode <= x"2291";
            
            when x"20" => opcode <= x"2907";
            when x"21" => opcode <= x"330b";
                                  
            when x"22" => opcode <= x"350b";
            when x"23" => opcode <= x"371d";
                                  
            when x"24" => opcode <= x"3871";
            when x"25" => opcode <= x"392a";
                                   
            when x"26" => opcode <= x"3c78"; -- COM12 (0x3C) 0x78
            when x"27" => opcode <= x"4d40"; 
                                  
            when x"28" => opcode <= x"4e20";
            when x"29" => opcode <= x"6900"; -- GFIX (0x69) 0x00
                                   
            when x"2A" => opcode <= x"6b4a";
            when x"2B" => opcode <= x"7410";
                                  
            when x"2C" => opcode <= x"8d4f";
            when x"2D" => opcode <= x"8e00";
                                   
            when x"2E" => opcode <= x"8f00";
            when x"2F" => opcode <= x"9000";
                                  
            when x"30" => opcode <= x"9100";
            when x"31" => opcode <= x"9600";
                                  
            when x"32" => opcode <= x"9a00";
            when x"33" => opcode <= x"b084";
                                  
            when x"34" => opcode <= x"b10c";
            when x"35" => opcode <= x"b20e";
                                  
            when x"36" => opcode <= x"b382";
            when x"37" => opcode <= x"b80a";
  
            when others => opcode <= x"ffff";
			end case;
    end process;
end Behavioral;
