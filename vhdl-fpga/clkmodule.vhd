library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity clkmodule is
    Port ( clk100 : in STD_LOGIC;
           clk25 : out STD_LOGIC);
end clkmodule;

architecture Behavioral of clkmodule is
    signal count : unsigned (1 downto 0):="00";
    signal clk : std_logic:= '0';
begin
    CLK25 <= CLK;
    process(clk100)
    begin
        if rising_edge(clk100) then
            if count < "01" then
                count <= count +1;
            else 
                count <= "00";
                clk <= not clk ;
            end if;
        end if;
    end process;
end Behavioral;
