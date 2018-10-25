-- Debounce push button
-- clk --> Board's master clock
-- push_buton --> input
-- db_pulse --> output

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce is
    Port ( clk : in  STD_LOGIC;
           push_button : in  STD_LOGIC;
           db_pulse : out  STD_LOGIC);
end debounce;

architecture rtl of debounce is

	signal delay : STD_LOGIC_VECTOR(2 downto 0);

begin
	process(clk)
	begin
		if rising_edge(clk) then
			delay(0) <= push_button;
			delay(1) <= delay(0);
			delay(2) <= delay(1);
		end if;
	end process;
	db_pulse <= delay(0) AND delay(1) AND NOT delay(2);
end rtl;

