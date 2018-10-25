-- Control Matrix
-- LDA --> LOAD A register
-- ADD --> ADD B to A
-- SUB --> SUBSTRACT B from A
-- OPT --> OUTPUT A register content
-- T --> Timing sequence
-- control_bus_o --> well, you got it

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_matrix is
    Port ( LDA : in  STD_LOGIC;
           ADD : in  STD_LOGIC;
           SUB : in  STD_LOGIC;
           OPT : in  STD_LOGIC;
           T : in  STD_LOGIC_VECTOR (5 downto 0);
           control_bus_o : out  STD_LOGIC_VECTOR (11 downto 0));
end control_matrix;

architecture rtl of control_matrix is

begin
--control bus assignment
-- 11 -> cp
-- 10 -> ep
--  9 -> lm
--  8 -> ce
--  7 -> li
--  6 -> ei
--  5 -> la
--  4 -> ea
--  3 -> su
--  2 -> eu
--  1 -> lb
--  0 -> lo

	control_bus_o(11) <= T(1);
	control_bus_o(10) <= T(0);
	control_bus_o(9) <= T(0) OR (T(3) AND (LDA OR ADD OR SUB));
	control_bus_o(8) <= T(2) OR (T(4) AND (LDA OR ADD OR SUB));
	control_bus_o(7) <= T(2);
	control_bus_o(6) <= T(3) AND (LDA OR ADD OR SUB);
	control_bus_o(5) <= (T(4) AND LDA) OR (T(5) AND (ADD OR SUB));
	control_bus_o(4) <= T(3) AND OPT;
	control_bus_o(3) <= T(5) AND SUB;
	control_bus_o(2) <= T(5) AND (ADD OR SUB);
	control_bus_o(1) <= T(4) AND (ADD OR SUB);
	control_bus_o(0) <= T(3) AND OPT;

end rtl;

