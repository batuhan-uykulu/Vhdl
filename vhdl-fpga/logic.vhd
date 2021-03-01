library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           logout : out STD_LOGIC_VECTOR (3 downto 0));
end logic;

 architecture Behavioral of logic is
begin

logout(0)<= (a(0)and(not b(0))and s1 and(not s0))or(a(0)and s0 and(not s1))or(a(0)and b(0) and(not s1))or(b(0)and s1 and(not a(0)))or(s1 and s0 and(not a(0)))or
(b(0)and s0 and(not s1)); 
logout(1)<= (a(1)and(not b(1))and s1 and(not s0))or(a(1)and s0 and(not s1))or(a(1)and b(1) and(not s1))or(b(1)and s1 and(not a(1)))or(s1 and s0 and(not a(1)))or
(b(1)and s0 and(not s1));
logout(2)<= (a(2)and(not b(2))and s1 and(not s0))or(a(2)and s0 and(not s1))or(a(2)and b(2) and(not s1))or(b(2)and s1 and(not a(2)))or(s1 and s0 and(not a(2)))or
(b(2)and s0 and(not s1));
logout(3)<= (a(3)and(not b(3))and s1 and(not s0))or(a(3)and s0 and(not s1))or(a(3)and b(3) and(not s1))or(b(3)and s1 and(not a(3)))or(s1 and s0 and(not a(3)))or
(b(3)and s0 and(not s1)); 

end Behavioral;
