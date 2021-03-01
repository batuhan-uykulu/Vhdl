library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vgadriver is
    Port ( clk25   : in  STD_LOGIC;
           vsync   : out STD_LOGIC;
           hsync   : out STD_LOGIC;
           vgaRed  : out std_logic_vector(3 downto 0);
           vgaBlue : out std_logic_vector(3 downto 0);
           vgaGreen: out std_logic_vector(3 downto 0);
           din     : in  std_logic_vector(11 downto 0);
           addr    : out std_logic_vector(14 downto 0) );
end vgadriver;

architecture Behavioral of vgadriver is

    signal hcount  : unsigned(9 downto 0):= (others => '0');
    signal vcount  : unsigned(9 downto 0):= (others => '0');
    signal hs, vs  : std_logic:='1';
    signal cp ,np  : std_logic_vector(11 downto 0):= (others => '0');
    signal naddr   : unsigned(14 downto 0):= (others => '0'); 
    signal g: unsigned (3 downto 0):=(others => '0');
    signal val: STD_LOGIC_VECTOR(14 downto 0):= (others => '0');
     
begin
hsync <= hs;
vsync <= vs;
addr  <= std_logic_vector(naddr);
np    <= din;
--g     <=  (unsigned(cp(11 downto 8))+unsigned(cp(7 downto 4))+unsigned(cp(3 downto 0)))/3;

timing:    process(clk25)
    begin
    if rising_edge(clk25) then 
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
    
imagedisplay:process(vs,hs,clk25)
    begin
        if rising_edge(clk25)then
            if ( to_integer(hcount) < 160) and (to_integer(vcount) < 120)  then
                vgaRed   <= cp(11 downto 8) ;
                vgaGreen <= cp(7 downto 4) ;
                vgaBlue  <= cp(3 downto 0);
            else
                vgaRed <= x"0";
                vgaBlue <= x"0";
                vgaGreen <= x"0";
            end if;
        end if;
    end process;

acqrpdatamemif :
     process(hcount, vcount, clk25) 
     begin
     if rising_edge(clk25)then
        cp <= np;
        if to_integer(hcount) < 160 and to_integer(vcount) < 120 then
               naddr <= hcount(7 downto 0) + ((vcount(6 downto 0)+"100") * x"a0" );
                if to_integer(naddr) >= 19200 then 
                    naddr <= (others => '0');
                end if;
        end if;   
    end if;
    end process;
    
end Behavioral;
