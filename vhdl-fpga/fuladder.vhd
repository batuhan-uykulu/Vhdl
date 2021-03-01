library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fuladder is
    Port ( I1 : in STD_LOGIC;
           I2 : in STD_LOGIC;
           cin : in STD_LOGIC;
           cout : out STD_LOGIC;
           sout: out std_logic);
end fuladder;

architecture Behavioral of fuladder is
begin
sout <= I1 xor I2 xor cin;
cout <= (I1 and I2)or(I2 and cin)or(I1 and cin);
end Behavioral;
