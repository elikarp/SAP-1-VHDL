-- Input & Memory Address Register
-- clk --> SAP-1 main clock
-- lm --> load MAR
-- addr_sw_i --> address port in PROG mode
-- RP --> RUN/PROG'
-- addr_bus_i --> from address bus
-- addr_o --> towards RAM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IMAR is
    Port ( clk : in  STD_LOGIC;
           lm : in  STD_LOGIC;
           addr_sw_i : in  STD_LOGIC_VECTOR (3 downto 0);
           RP : in  STD_LOGIC;
           addr_bus_i : in  STD_LOGIC_VECTOR (3 downto 0);
           addr_o : out  STD_LOGIC_VECTOR (3 downto 0));
end IMAR;

architecture rtl of IMAR is
	COMPONENT mux21
	PORT(
		a : IN std_logic;
		b : IN std_logic;
		s : IN std_logic;          
		m : OUT std_logic
		);
	END COMPONENT;
	signal r_addr_bus : std_logic_vector(3 downto 0);
begin
	process(clk,lm)
	begin
		if rising_edge(clk) then
			if lm = '1' then
				r_addr_bus <= addr_bus_i;
			end if;
		end if;
	end process;
	mux24: FOR j IN 0 TO 3 GENERATE
		Inst_mux21: mux21 PORT MAP(
			a => addr_sw_i(j),
			b => r_addr_bus(j),
			s => RP,
			m => addr_o(j)
		);
	END GENERATE mux24;
end rtl;

