library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkgen is
port( clk100  : in std_logic;
      clk50   : out std_logic;
      clk25   : out std_logic;
      clk800k : out std_logic 
 );
end clkgen;

architecture behavioural of clkgen is
    signal count50 : unsigned(1 downto 0):= "00";
    signal count25 : unsigned(1 downto 0):= "00";
    signal count800 : unsigned(9 downto 0):= (others => '0'); 
    signal s50, s25,s800: std_logic:='1';
begin
    clk50 <= s50;
    clk25 <= s25;
    clk800k <= s800;
    process (clk100)
    begin
        if rising_edge(clk100) then 
            if count25 < "01" then
                count25<= count25 +1;
            else
                count25 <= "00";
                s25 <= not s25;
            end if;
        end if;
    end process;
process (clk100)
begin
        if rising_edge(clk100) then 
                s50 <= not s50;
        end if;
end process;
process(clk100)
begin
    if rising_edge(clk100) then
        if to_integer(count800) < 1000  then        
            count800 <= count800 +1;
        else
            count800 <= (others => '0');
            s800 <= not s800;
        end if;
    end if;
end process;    
end behavioural;