library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JKFF is
    Port ( J : in  STD_LOGIC;
           K : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           Q : inout  STD_LOGIC;
           notQ : inout  STD_LOGIC);
end JKFF;

architecture rtl of JKFF is

begin
process(clk,clr)
begin
	if(clr = '1') then
		Q <= '0';
		notQ <= '1';
	elsif (rising_edge(clk)) then
		if(J='0' and K='0')then
			Q <= Q;
			notQ <= not Q;
		elsif(J='0' and K='1')then
			Q <= '0';
			notQ <= '1';
		elsif(J='1' and K='0')then
			Q <= '1';
			notQ <= '0';
		else Q <= not Q;
			notQ <= Q;
		end if;
	end if;
end process;

end rtl;

