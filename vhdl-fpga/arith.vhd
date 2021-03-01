library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arith is
    Port (s0 : in STD_LOGIC;
          s1 : in STD_LOGIC; 
          a  : in std_logic_vector(3 downto 0);
          b  : in std_logic_vector(3 downto 0);
          sum: out std_logic_vector(3 downto 0);
          ovr : out std_logic);
end arith;

architecture Behavioral of arith is
component alext is
    Port ( s0 : in STD_LOGIC;
           s1 : in STD_LOGIC;
           xi : in STD_LOGIC;
           adin : out STD_LOGIC);
    end component;
    
    component fuladder is
    Port ( I1 : in STD_LOGIC;
           I2 : in STD_LOGIC;
           cin : in STD_LOGIC;
           cout : out STD_LOGIC;
           sout: out std_logic);
    end component; 
    signal xb : std_logic_vector(3 downto 0);
    signal c1, c2, c3, co : std_logic;  
begin

al_ext1: alext port map(s0 => s0, s1 => s1, xi => b(0), adin => xb(0));
al_ext2: alext port map(s0 => s0, s1 => s1, xi => b(1), adin => xb(1));
al_ext3: alext port map(s0 => s0, s1 => s1, xi => b(2), adin => xb(2));
al_ext4: alext port map(s0 => s0, s1 => s1, xi => b(3), adin => xb(3));

fa1 : fuladder port map (I1 => a(0), I2 => xb(0), cin => s0, cout =>c1, sout=> sum(0));
fa2 : fuladder port map (I1 => a(1), I2 => xb(1), cin => c1, cout =>c2, sout=> sum(1));
fa3 : fuladder port map (I1 => a(2), I2 => xb(2), cin => c2, cout =>c3, sout=> sum(2));
fa4 : fuladder port map (I1 => a(3), I2 => xb(3), cin => c3, cout =>co, sout=> sum(3));
ovr <= co xor c3;
  
end Behavioral;

