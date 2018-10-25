-- Control Unit
-- clk100MHz --> Board's Master clock
-- clk_o --> SAP-1 main clock @1kHz
-- opcode_i --> OPCode from IREG
-- control_bus_o --> well, you got it
-- AM --> Auto/Manual'
-- HLT --> HALT signal
-- pulse_i --> clock pulse input for Manual mode

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( clk100MHz : in  STD_LOGIC;
           clk_o : out  STD_LOGIC;
           clr : in  STD_LOGIC;
           opcode_i : in  STD_LOGIC_VECTOR (3 downto 0);
           control_bus_o : out  STD_LOGIC_VECTOR (11 downto 0);
           AM : in  STD_LOGIC;
			  HLT : out  STD_LOGIC;
           pulse_i : in  STD_LOGIC);
end CU;

architecture rtl of CU is
	COMPONENT RC
	PORT(
		clk : IN std_logic;
		clr : IN std_logic;          
		T : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	COMPONENT op_decoder
	PORT(
		opcode : IN std_logic_vector(3 downto 0);          
		LDA : OUT std_logic;
		ADD : OUT std_logic;
		SUB : OUT std_logic;
		OPT : OUT std_logic;
		HLT : OUT std_logic
		);
	END COMPONENT;
	COMPONENT control_matrix
	PORT(
		LDA : IN std_logic;
		ADD : IN std_logic;
		SUB : IN std_logic;
		OPT : IN std_logic;
		T : IN std_logic_vector(5 downto 0);          
		control_bus_o : OUT std_logic_vector(11 downto 0)
		);
	END COMPONENT;
	COMPONENT freq_divider
	PORT(
		clk_i : IN std_logic;
		clr : IN std_logic;          
		clk_o : OUT std_logic
		);
	END COMPONENT;
	
	signal r_clk1kHz : std_logic;
	signal r_clk_o : std_logic;
	signal r_LDA : std_logic;
	signal r_ADD : std_logic;
	signal r_SUB : std_logic;
	signal r_OPT : std_logic;
	signal r_HLT : std_logic;
	signal r_T : std_logic_vector(5 downto 0);
	
begin

	Inst_RC: RC PORT MAP(
		clk => r_clk_o,
		clr => clr,
		T => r_T
	);
	Inst_op_decoder: op_decoder PORT MAP(
		opcode => opcode_i,
		LDA => r_LDA,
		ADD => r_ADD,
		SUB => r_SUB,
		OPT => r_OPT,
		HLT => r_HLT
	);
	Inst_control_matrix: control_matrix PORT MAP(
		LDA => r_LDA,
		ADD => r_ADD,
		SUB => r_SUB,
		OPT => r_OPT,
		T => r_T,
		control_bus_o => control_bus_o
	);
	Inst_freq_divider: freq_divider PORT MAP(
		clk_i => clk100MHz,
		clr => clr,
		clk_o => r_clk1kHz
	);

	r_clk_o <= ((r_clk1kHz AND AM) OR (pulse_i AND NOT AM)) AND NOT r_HLT;
	clk_o <= r_clk_o;
	HLT <= r_HLT;

end rtl;

