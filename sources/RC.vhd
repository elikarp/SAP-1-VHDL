-- Ring Counter
-- clk --> SAP-1 main clock
-- clr --> asynchronous clear input
-- T --> Timing sequence

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RC is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           T : out  STD_LOGIC_VECTOR (5 downto 0));
end RC;

architecture rtl of RC is
	COMPONENT JKFF
	PORT(
		J : IN std_logic;
		K : IN std_logic;
		clk : IN std_logic;
		clr : IN std_logic;       
		Q : INOUT std_logic;
		notQ : INOUT std_logic
		);
	END COMPONENT;

	signal r_n_clk : std_logic;						--negative clock signal
	signal r_T : std_logic_vector(5 downto 0);	--Times signal connected to FF's Q output
	signal r_n_T : std_logic_vector(5 downto 0);	--Complemented Times signal connected to FF's notQ output

begin
	r_n_clk <= NOT clk;
	FF0: JKFF PORT MAP(	--First FlipFlop's inputs and outputs are switched
		J => r_n_T(5),
		K => r_T(5),
		clk => r_n_clk,
		clr => clr,
		Q => r_n_T(0),
		notQ => r_T(0)
	);
	FF_Array: for j in 1 to 5 generate
		FFN: JKFF PORT MAP(
			J => r_T(j-1),
			K => r_n_T(j-1),
			clk => r_n_clk,
			clr => clr,
			Q => r_T(j),
			notQ => r_n_T(j)
		);
	end generate;
	T <= r_T;
end rtl;

