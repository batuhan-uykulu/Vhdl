library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alext is
    Port ( s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           xi : in STD_LOGIC;
           adin : out STD_LOGIC);
end alext;

architecture Behavioral of alext is
begin
adin <= ((not s0)and(not s1)and xi)or((not xi)and(not s1)and s0);
end Behavioral;
