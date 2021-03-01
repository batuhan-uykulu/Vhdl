library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity converter is
    Port ( b1 : in STD_LOGIC;
           b0 : in STD_LOGIC;
           g1 : out STD_LOGIC;
           g0 : out STD_LOGIC);
end converter;

architecture Behavioral of converter is

begin
g1 <= b1;
g1 <= b0 xor b1;
end Behavioral;
