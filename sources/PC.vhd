-- Program Counter
-- cp --> Count
-- clk -- SAP-1 main clock
-- clr --> asynchronous clear input
-- ep --> output enable
-- count_obuf --> tri-state buffer output

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( cp : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           ep : in  STD_LOGIC;
           count_obuf : out  STD_LOGIC_VECTOR (3 downto 0));
end PC;

architecture rtl of PC is
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
	
	signal r_count : std_logic_vector(3 downto 0);
	signal r_ripple : std_logic_vector(4 downto 0);
begin
	r_ripple(0) <= clk;

	JKFF_Array: FOR j IN 0 TO 3 GENERATE 
		Inst_JK: JKFF PORT MAP(
			J => cp,
			K => cp,
			clk => r_ripple(j),
			clr => clr,
			Q => r_count(j),
			notQ =>r_ripple(j+1)
		);
	end generate JKFF_Array;
	count_obuf <= r_count when (ep = '1') else (others => 'Z');
end rtl;

