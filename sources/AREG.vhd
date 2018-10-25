-- Accumulator Register
-- clk --> SAP-1 main clock
-- la --> Load A register
-- ea --> A register output Enable
-- data_i --> input from data_bus
-- data_o --> data output towards ASU
-- data_obuf --> tri-state buffer output

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity AREG is
    Port ( clk : in  STD_LOGIC;
           la : in  STD_LOGIC;
           ea : in  STD_LOGIC;
           data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           data_o : out  STD_LOGIC_VECTOR (7 downto 0);
           data_obuf : out  STD_LOGIC_VECTOR (7 downto 0));
end AREG;

architecture rtl of AREG is
	signal r_data : std_logic_vector(7 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if la = '1' then
				r_data <= data_i;
			end if;
		end if;
	end process;
	data_o <= r_data;
	data_obuf <= r_data when (ea = '1') else (others => 'Z');
end rtl;