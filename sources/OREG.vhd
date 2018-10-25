-- Output Register
-- clk --> SAP-1 main clock
-- lo --> Load Output register
-- data_i --> input from data_bus
-- data_o --> data output towards Binary led display

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OREG is
    Port ( clk : in  STD_LOGIC;
           lo : in  STD_LOGIC;
           data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           data_o : out  STD_LOGIC_VECTOR (7 downto 0));
end OREG;

architecture rtl of OREG is
	signal r_data : std_logic_vector(7 downto 0) := (others => '0');
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if lo = '1' then
				r_data <= data_i;
			end if;
		end if;
	end process;
	data_o <= r_data;
end rtl;

