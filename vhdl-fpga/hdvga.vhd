library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hvcounter is
    Port ( clk : in STD_LOGIC;
           vsync : out STD_LOGIC;
           hsync : out STD_LOGIC;
         --  imon  : out std_logic;
        --   vpos  : out std_logic_vector(9 downto 0);
       --    hpos  : out std_logic_vector(9 downto 0);
           vgaRed: out std_logic_vector(3 downto 0);
           vgaBlue: out std_logic_vector(3 downto 0);
           vgaGreen: out std_logic_vector(3 downto 0);
           sw: in std_logic_vector(11 downto 0));
end hvcounter;

architecture Behavioral of hvcounter is
    
    signal hcount: unsigned(10 downto 0):= (others => '0');
    signal vcount: unsigned(10 downto 0):= (others => '0');
    signal hs, vs  : std_logic:='1';

begin


hsync <= hs;
vsync <= vs;
--hpos <= std_logic_vector(hcount);
--vpos <= std_logic_vector(vcount);

timing:    process(clk)
    begin
    if rising_edge(clk) then 
        if to_integer(hcount) < 1280 then --display            hs<='1';
            hcount <= hcount +1; 
        elsif to_integer(hcount) < 1328 then --front porch
            hcount <= hcount +1;
        elsif to_integer(hcount) < 1440 then --sync pulse
            hs<='0';
            hcount <= hcount +1;
        elsif to_integer(hcount) < 1688 then --back porch
            hs<='1';
            hcount <= hcount +1;
        else
            vcount <= vcount + 1;
             if to_integer(vcount) < 1024 then --display
                vs<='1';
             elsif to_integer(vcount) < 1025 then    
                vs <='1';
             elsif to_integer(vcount) < 1028 then    
                vs<='0';
             elsif to_integer(vcount) < 1066 then
                vs<='1';
             else    
                vcount <= (others => '0');          
             end if;
             
            hcount <= (others => '0'); 
        end if;
    end if;
    end process;   

imagedisplay:process(vs,hs,clk)
    begin
        if rising_edge(clk)then
            if to_integer(hcount) < 1280 and to_integer(vcount) < 1024  then
          --      imon <= '1';
                vgaRed   <= sw(3 downto 0);
                vgaGreen <= sw(7 downto 4);
                vgaBlue  <= sw(11 downto 8);
            else    
         --       imon <= '0';
                vgaRed <= x"0";
                vgaBlue <= x"0";
                vgaGreen <= x"0";
            end if;
        end if;
    end process;

end Behavioral;
