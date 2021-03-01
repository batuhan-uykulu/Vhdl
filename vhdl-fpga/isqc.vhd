library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity isqc is
    Port ( clk800k : in STD_LOGIC;--make 800k
           subin   : in STD_LOGIC_vector(15 downto 0);
           advanced : in std_logic;
           done    : out STD_LOGIC;
           ssc     : out STD_LOGIC;
           ssd     : out STD_LOGIC);
end isqc;

architecture Behavioral of isqc is
    type state is (s0,s1,s2,s3,s4,s5);
    signal s : state:= s0;
    signal scl,sda : std_logic := '1';
    signal idx : integer range 0 to 26;
    signal dout : std_logic_vector(26 downto 0):=(others => '0');
    signal d : std_logic :='0';
begin
dout <= x"42" & '0' & subin(15 downto 8) & '0' & subin(7 downto 0) & '0';
ssc <= scl;
ssd <= sda;
done <= d;
    process(clk800k)begin
        if rising_edge(clk800k) then
            case s is
                when s0 =>
                   scl <= '1'; 
                   sda <= '1'; 
                   s <= s1;
                   d <= '0' ;
                when s1 =>
                    scl <= '1';
                    sda <= '0';
                    s <= s2;
                    idx <= 26;
                    d <= '0' ;
                when s2 => 
                    s <= s3;
                    scl <= '0';
                    sda <= dout(idx);
                    d <= '0' ;
                when s3 =>
                    scl <= '1';
                    d <= '0' ;     
                    if (idx -1) >= 0 then  
                        idx <= idx - 1;
                        s <= s2;
                    else
                        idx <= 26;
                        s <= s4;
                    end if;
                when s4 => 
                    scl <= '0';
                    sda <= '1';
                    s <= s5;
                    d <= '0' ;
                when s5 =>
                    scl <= '1';
                    sda <= '1';
                    d <= '1' ;
                    if advanced = '1' then 
                        s <= s0;
                        d <= '0'; 
                    else
                        s <= s5;
                        d <= '1';
                    end if;                    
            end case;
        end if;
    end process;
end Behavioral;
