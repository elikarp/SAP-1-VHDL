--Simple-As-Posible computer written in VHDL for Nexys4 DDR

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SAP_1_top is
    Port ( clk100MHz : in  STD_LOGIC;
           pulse_btn_i : in  STD_LOGIC;
           data_sw_i : in  STD_LOGIC_VECTOR (7 downto 0);
           addr_sw_i : in  STD_LOGIC_VECTOR (3 downto 0);
           clr_btn_i : in  STD_LOGIC;
			  we_btn_i : in  STD_LOGIC;
           RP_sw_i : in  STD_LOGIC;
           AM_sw_i : in  STD_LOGIC;
           data_ld_o : out  STD_LOGIC_VECTOR (7 downto 0);
           addr_ld_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  cout_ld_o : out  STD_LOGIC;
           RP_ld_o : out  STD_LOGIC;
           AM_ld_o : out  STD_LOGIC;
           HLT_ld_o : out  STD_LOGIC);
end SAP_1_top;

architecture rtl of SAP_1_top is
	COMPONENT AREG
	PORT(
		clk : IN std_logic;
		la : IN std_logic;
		ea : IN std_logic;
		data_i : IN std_logic_vector(7 downto 0);          
		data_o : OUT std_logic_vector(7 downto 0);
		data_obuf : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT ASU
	PORT(
		a_data_i : IN std_logic_vector(7 downto 0);
		b_data_i : IN std_logic_vector(7 downto 0);
		su : IN std_logic;
		eu : IN std_logic;          
		cout : OUT std_logic := '0';
		s_data_obuf : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT BREG
	PORT(
		clk : IN std_logic;
		lb : IN std_logic;
		data_i : IN std_logic_vector(7 downto 0);          
		data_o : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT OREG
	PORT(
		clk : IN std_logic;
		lo : IN std_logic;
		data_i : IN std_logic_vector(7 downto 0);          
		data_o : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT PC
	PORT(
		cp : IN std_logic;
		clk : IN std_logic;
		clr : IN std_logic;
		ep : IN std_logic;          
		count_obuf : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT IMAR
	PORT(
		clk : IN std_logic;
		lm : IN std_logic;
		addr_sw_i : IN std_logic_vector(3 downto 0);
		RP : IN std_logic;
		addr_bus_i : IN std_logic_vector(3 downto 0);          
		addr_o : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT RAM
	PORT(
		we : IN std_logic;
		ce : IN std_logic;
		addr : IN std_logic_vector(3 downto 0);
		data_i : IN std_logic_vector(7 downto 0);          
		data_o : OUT std_logic_vector(7 downto 0);
		data_obuf : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT IREG
	PORT(
		clk : IN std_logic;
		li : IN std_logic;
		ei : IN std_logic;
		clr : IN std_logic;
		data_i : IN std_logic_vector(7 downto 0);          
		data_obuf : OUT std_logic_vector(3 downto 0);
		control_data_o : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT CU
	PORT(
		clk100MHz : IN std_logic;
		clr : IN std_logic;
		opcode_i : IN std_logic_vector(3 downto 0);
		AM : IN std_logic;
		pulse_i : IN std_logic;          
		clk_o : OUT std_logic;
		control_bus_o : OUT std_logic_vector(11 downto 0);
		HLT : OUT std_logic
		);
	END COMPONENT;
	COMPONENT debounce
	PORT(
		clk : IN std_logic;
		push_button : IN std_logic;          
		db_pulse : OUT std_logic
		);
	END COMPONENT;
	COMPONENT mux21
	PORT(
		a : IN std_logic;
		b : IN std_logic;
		s : IN std_logic;          
		m : OUT std_logic
		);
	END COMPONENT;
	
	signal r_clk : std_logic;
	signal r_clr : std_logic;
	signal r_we_db : std_logic;
	signal r_we : std_logic;
	signal r_data_ram : std_logic_vector(7 downto 0);
	signal r_A_data : std_logic_vector(7 downto 0);
	signal r_B_data : std_logic_vector(7 downto 0);
	signal r_O_data : std_logic_vector(7 downto 0) := "00000000";
	signal r_pulse_db : std_logic;
	signal r_addr_ram : std_logic_vector(3 downto 0);
	signal r_data_bus : std_logic_vector(7 downto 0) := "00000000";
	signal r_instruction : std_logic_vector(3 downto 0);
	signal r_control_bus : std_logic_vector(11 downto 0);
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
begin

	Inst_AREG: AREG PORT MAP(
		clk => r_clk,
		la => r_control_bus(5),
		ea => r_control_bus(4),
		data_i => r_data_bus,
		data_o => r_A_data,
		data_obuf => r_data_bus
	);
	Inst_ASU: ASU PORT MAP(
		a_data_i => r_A_data,
		b_data_i => r_B_data,
		su => r_control_bus(3),
		eu => r_control_bus(2),
		cout => cout_ld_o,
		s_data_obuf => r_data_bus
	);
	Inst_BREG: BREG PORT MAP(
		clk => r_clk,
		lb => r_control_bus(1),
		data_i => r_data_bus,
		data_o => r_B_data
	);
	Inst_OREG: OREG PORT MAP(
		clk => r_clk,
		lo => r_control_bus(0),
		data_i => r_data_bus,
		data_o => r_O_data
	);
	Inst_PC: PC PORT MAP(
		cp => r_control_bus(11),
		clk => r_clk,
		clr => r_clr,
		ep => r_control_bus(10),
		count_obuf => r_data_bus(3 downto 0)
	);
	Inst_IMAR: IMAR PORT MAP(
		clk => r_clk,
		lm => r_control_bus(9),
		addr_sw_i => addr_sw_i,
		RP => RP_sw_i,
		addr_bus_i => r_data_bus(3 downto 0),
		addr_o => r_addr_ram
	);
	Inst_RAM: RAM PORT MAP(
		we => r_we,
		ce => r_control_bus(8),
		addr => r_addr_ram,
		data_i => data_sw_i,
		data_o => r_data_ram,
		data_obuf => r_data_bus
	);
	Inst_IREG: IREG PORT MAP(
		clk => r_clk,
		li => r_control_bus(7),
		ei => r_control_bus(6),
		clr => r_clr,
		data_i => r_data_bus,
		data_obuf => r_data_bus(3 downto 0),
		control_data_o => r_instruction
	);
	Inst_CU: CU PORT MAP(
		clk100MHz => clk100MHz,
		clk_o => r_clk,
		clr => r_clr,
		opcode_i => r_instruction,
		control_bus_o => r_control_bus,
		AM => AM_sw_i,
		HLT => HLT_ld_o,
		pulse_i => r_pulse_db
	);
	pulse_debounce: debounce PORT MAP(
		clk => clk100MHz,
		push_button => pulse_btn_i,
		db_pulse => r_pulse_db
	);

	mux28: FOR j IN 0 TO 7 GENERATE
			Inst_mux21: mux21 PORT MAP(
		a => r_data_ram(j),
		b => r_O_data(j),
		s => RP_sw_i,
		m => data_ld_o(j)
	);
	END GENERATE mux28;
	
	r_we <= we_btn_i AND NOT RP_sw_i;
	r_clr <= (NOT RP_sw_i) OR clr_btn_i;
	addr_ld_o <= addr_sw_i;
	RP_ld_o <= RP_sw_i;
	AM_ld_o <= AM_sw_i;
end rtl;

