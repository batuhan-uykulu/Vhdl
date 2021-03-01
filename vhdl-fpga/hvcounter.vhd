library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;
entity vga is
    Port ( clk25 : in STD_LOGIC;
           vsync : out STD_LOGIC;
            Nblank : out  STD_LOGIC;								
             activeArea : out  STD_LOGIC;
             HSYNC : OUT STD_LOGIC);
end vga;

architecture Behavioral of vga is

    signal clk : std_logic;   
    signal hcount: unsigned(9 downto 0):= (others => '0');
    signal vcount: unsigned(9 downto 0):= (others => '0');
    signal hs, vs  : std_logic:='1';
    signal g: unsigned (3 downto 0):=(others => '0'); 
    --signal r1,r2, g1, g2, b1, b2 : unsigned(3 downto 0):="0000";
begin
hsync <= hs;
vsync <= vs;
--g <= (unsigned(sw(3 downto 0)) + unsigned(sw(7 downto 4)) + unsigned(sw(11 downto 8))) / 3 ;
timing:    process(clk)
    begin
    if rising_edge(clk) then 
        if to_integer(hcount) < 640 then --display            hs<='1';
            hcount <= hcount +1; 
        elsif to_integer(hcount) < 656 then --front porch
            hcount <= hcount +1;
        elsif to_integer(hcount) < 752 then --front porch
            hs<='0';
            hcount <= hcount +1;
        elsif to_integer(hcount) < 800 then --front porch
            hs<='1';
            hcount <= hcount +1;
        else
            vcount <= vcount + 1;
             if to_integer(vcount) < 480 then --display
                vs<='1';
             elsif to_integer(vcount) < 491 then    
                vs <='1';
             elsif to_integer(vcount) < 493 then    
                vs<='0';
             elsif to_integer(vcount) < 524 then
                vs<='1';
             else    
                vcount <= (others => '0');          
             end if;
             
            hcount <= (others => '0'); 
        end if;
    end if;
    end process;   
magedisplay:process(clk)
    begin
        if rising_edge(clk)then
            if ( to_integer(hcount) < 160) and (to_integer(vcount) < 120)  then
                activearea <= '1';
            else
                            activearea <= '1';
            end if;
            
            if   ( to_integer(hcount) < 640) and (to_integer(vcount) < 480)  then
                nblank <= '0';
            else 
            nblank <= '0';
            end if;
        end if;
    end process;

end Behavioral;
