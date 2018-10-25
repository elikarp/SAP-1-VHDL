-- B Register
-- clk --> SAP-1 main clock
-- lb --> Load B register
-- data_i --> input from data_bus
-- data_o --> data output towards ASU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BREG is
    Port ( clk : in  STD_LOGIC;
           lb : in  STD_LOGIC;
           data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           data_o : out  STD_LOGIC_VECTOR (7 downto 0));
end BREG;

architecture rtl of BREG is
	signal r_data : std_logic_vector(7 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if lb = '1' then
				r_data <= data_i;
			end if;
		end if;
	end process;
	data_o <= r_data;
end rtl;

