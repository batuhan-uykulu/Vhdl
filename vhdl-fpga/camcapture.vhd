library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity camcapture is
  Port(clk   : in   std_logic;
       pclk  : in   STD_LOGIC;--(25M)
       vsyncc : in   STD_LOGIC;
       href  : in   STD_LOGIC;
       d     : in   STD_LOGIC_VECTOR (7 downto 0);
       addr  : out  STD_LOGIC_VECTOR (14 downto 0);
       dout  : out  STD_LOGIC_VECTOR (7 downto 0);
       we    : out  STD_LOGIC_vector(0 downto 0) );
end camcapture;

architecture Behavioral of camcapture is
    -------
    type pstate is (ps0,ps1);
    signal ps : pstate:= ps0;
    signal pdatatemp : std_logic_vector(11 downto 0):= x"000";
    signal pdatareg  : std_logic_vector(11 downto 0):= x"000";
    -------
    type wstate is (w0,w1);
    signal ws : wstate := w0; 
    ------
    signal qqvgahref : std_logic := '0';
    type hstate is (hs0, hs1, hs2);
    signal hs : hstate := hs0;
    signal hs2count : unsigned(2 downto 0):= "000";
    ------
    signal vln : unsigned (6 downto 0):= "0000000";
    signal hpn : unsigned (7 downto 0):= x"00";
    signal adress : std_LOGIC_VECTOR (14 downto 0) := (others => '0');
    signal wactive: std_logic:= '0';
    ----
    signal hpwm  : std_logic:= '0';
    signal pcount: unsigned(2 downto 0) := "000";
begin
adress <= std_logic_vector((hpn) +(vln * "10100000"));

pwmpclk: process(pclk)
begin
    if rising_edge(pclk) then
        pcount <= pcount +1;
        if pcount < "010" then 
            hpwm <= '1';
        else
            hpwm <= '0';
        end if;
    end if;
end process;

pdatacapture :
process(pclk) is begin
    if falling_edge(pclk) then
       if qqvgahref = '1' and vsyncc = '0' and hpwm = '1' then 
            case ps is       
                when ps0 => 
                    pdatatemp(11 downto 8) <= d(3 downto 0);
                    ps <= ps1;    
                when ps1 => 
                    pdatatemp(7 downto 0) <= d;
                    pdatareg <= pdatatemp;
                    wactive <= '1';
                    ps <= ps0;
            end case;
        end if;
    end if;   
end process;

--wactivation:
--process(pdatareg) is begin
--    wactive <= '0';
--    if pdatareg' event then 
--        wactive <= '1';
--    end if;
--end process;

qqvgahrefcreate : 
process (href)
begin
    if rising_edge(href) or falling_edge(href) then
        case hs is
            when hs0 =>
                qqvgahref <= '1';
                hs <= hs1;
            when hs1 => 
                qqvgahref <= '0';
                hs <= hs2;
            when hs2 => 
                qqvgahref <= '0';
                if hs2count < "110"  then
                    hs2count <= hs2count + 1;
                    hs <= hs2;
                else
                    hs2count <= "000";
                    hs <= hs0;
                end if;
        end case;
    end if;
end process;

writefsm: 
process(clk)is begin -- sysclk
    if falling_edge (clk) then
        if wactive = '1' then
            case ws is
                when w0 =>  
                    we <= "1";
                    addr <= adress;
                    dout <= pdatareg;
                    ws <= w1;
                when w1 =>
                    ws <=w0; 
                    hpn <= hpn +1 ;
                    wactive <= '0';
            end case ;
        else 
            ws <= w0 ;
            we <= "0";
            addr <= (others => 'Z');
            dout <= (others => 'Z');
        end if;   
    end if;
end process;

process(hpn,vln,clk) begin  
    if rising_edge(clk) then
        if to_integer(hpn) >= 160 then
            hpn <= (others => '0');
            vln <= vln + 1;
         end if;    
        if to_integer(vln) >= 120 then  
            hpn <= (others => '0');
            vln <= (others => '0');
        end if;
    end if;
end process;
end Behavioral;