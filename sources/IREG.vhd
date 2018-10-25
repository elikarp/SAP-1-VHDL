-- Instruction Register
-- clk --> SAP-1 main clock
-- li --> Load instruction register
-- ei --> Output enable
-- clr --> asynchronous clear signal
-- data_i --> input from data_bus
-- data_obuf --> tri-state buffer output towards address bus
-- control_data_o --> towards CU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IREG is
    Port ( clk : in  STD_LOGIC;
           li : in  STD_LOGIC;
           ei : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           data_obuf : out  STD_LOGIC_VECTOR (3 downto 0);
           control_data_o : out  STD_LOGIC_VECTOR (3 downto 0));
end IREG;

architecture rtl of IREG is
	signal r_data : std_logic_vector(7 downto 0);
begin
	process(clk,clr)
	begin
		if clr = '1' then
			r_data <= (others => '0');
		elsif rising_edge(clk) then
				if li = '1' then
					r_data <= data_i;
				end if;
		end if;
	end process;
	control_data_o <= r_data(7 downto 4);
	data_obuf <= r_data(3 downto 0) when (ei = '1') else (others => 'Z');
end rtl;

