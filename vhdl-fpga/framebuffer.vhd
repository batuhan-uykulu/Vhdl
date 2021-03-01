library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity framebuffer is
    Port ( red_r : out STD_LOGIC_vector(3 downto 0);
           gre_r : out STD_LOGIC_vector(3 downto 0);
           blu_r : out STD_LOGIC_vector(3 downto 0);
           vpos  : in STD_LOGIC_VECTOR (9 downto 0);
           hpos  : in STD_LOGIC_VECTOR (9 downto 0);
           clk   : in std_logic );
end framebuffer;

architecture Behavioral of framebuffer is
signal adtemp : unsigned(20 downto 0);
signal pix_adr : std_logic_vector(20 downto 0);

begin
adtemp <='0' & ( unsigned(vpos) * 480) + unsigned(hpos);     
    
    
    
--    process(clk,vpos,hpos)
--    begin
--        if rising_edge(clk) then
          
        
--        end if;
--    end process;
end Behavioral;
