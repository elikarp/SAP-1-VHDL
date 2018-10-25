-- Frequency divider
-- clk_i --> 100 MHz clock input
-- clr --> asynchronous clear input
-- clk_o --> 1 kHz clock output (counter'HIGH = 49999)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_divider is
    Port ( clk_i : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           clk_o : out  STD_LOGIC);
end freq_divider;

architecture rtl of freq_divider is
	signal temp: STD_LOGIC;
	signal counter: integer range 0 to 49999 := 0; 
begin
    process (clk_i, clr) 
	 begin
		if clr = '1' then
			temp <= '0';
         counter <= 0;
      elsif rising_edge(clk_i) then
			if counter = 49999 then
				temp <= NOT(temp); 		--toggle the o/p until the counter reachs its max
            counter <= 0;
			else
				counter <= counter + 1;
         end if;
		end if;
    end process;
    clk_o <= temp;
end rtl;

