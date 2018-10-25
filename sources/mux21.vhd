-- MUX 2 to 1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux21 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s : in  STD_LOGIC;
           m : out  STD_LOGIC);
end mux21;

architecture rtl of mux21 is

begin

	m <= (a AND NOT s) OR (b AND s);

end rtl;

