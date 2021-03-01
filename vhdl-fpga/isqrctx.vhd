library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tx is
    Port ( e  : in std_logic;
           clk100 : in STD_LOGIC;
           w : in STD_LOGIC_VECTOR (1 downto 0);
           y : out  std_logic );
end tx;

architecture Behavioral of tx is
    type state is (s0,s1,s2,s3,s4);
    signal stt : state := s0;
    signal yt : std_logic := '1';
begin
y <= yt;
process(clk100)begin
    if rising_edge(clk100)then
    if e = '1' then
    case stt is
       when s0 => stt <= s1; yt <= '0';  
       when s1 => stt <= s2; yt <= w(0);
       when s2 => stt <= s3; yt <= w(1);
       when s3 => stt <= s4; yt <= '0';
       when others => stt <= s0;yt <= '1';
    end case;
    else
        stt <= s0; yt <= '1';
    end if;
    end if;
end process;
end Behavioral;
