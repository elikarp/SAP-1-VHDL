-- 16x8 RAM (Program/Data memory)
-- we --> write enable
-- ce --> chip enable
-- addr --> address from IMAR
-- data_i --> input port
-- data_o --> output port
-- data_obuf --> tri-state buffer output

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
    Port ( we : in  STD_LOGIC;
			  ce : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (3 downto 0);
           data_i : in  STD_LOGIC_VECTOR (7 downto 0);
			  data_o : out  STD_LOGIC_VECTOR (7 downto 0);
           data_obuf : out  STD_LOGIC_VECTOR (7 downto 0));
end RAM;

architecture rtl of RAM is

	type vector_array is array(0 to 15) of std_logic_vector(7 downto 0);
	
	signal memory : vector_array;

begin
	process(we)
	begin
		if rising_edge(we) then
			memory(conv_integer(addr)) <= data_i;
		end if;
	end process;
	data_obuf <= memory(conv_integer(addr)) when (ce = '1') else (others => 'Z');
	data_o <= memory(conv_integer(addr));
end rtl;

