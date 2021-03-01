library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clkdiv is
    Port ( clk100 : in STD_LOGIC;
           clk: out std_logic);
end clkdiv;

architecture Behavioral of clkdiv is
signal count1 : unsigned(24 downto 0):=(others=> '0');
signal temp : std_logic:='0';
begin
clk <= temp;
process(clk100)begin
    if rising_edge(clk100) then
        if to_integer(count1) < 25000000 then count1 <= count1 + 1;
        else
            count1 <= (others=> '0');
            if temp = '0' then temp <= '1';
            else temp <= '0'; end if;
        end if;
    end if;
end process;
end Behavioral;
