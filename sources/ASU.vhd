-- Add/Sub Unit
-- a_data_i --> from AREG
-- b_data_i --> form BREG
-- su --> Substract
-- eu --> Output enable
-- cout --> Carry Out
-- s_data_obuf --> tri-state buffer output

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ASU is
    Port ( a_data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           b_data_i : in  STD_LOGIC_VECTOR (7 downto 0);
           su : in  STD_LOGIC;
           eu : in  STD_LOGIC;
			  cout : out  STD_LOGIC;
           s_data_obuf : out  STD_LOGIC_VECTOR (7 downto 0));
end ASU;

architecture rtl of ASU is
	COMPONENT full_adder
	PORT(
		a : IN std_logic;
		b : IN std_logic;
		cin : IN std_logic;          
		s : OUT std_logic;
		cout : OUT std_logic
		);
	END COMPONENT;
	
    signal r_carry : std_logic_vector(8 downto 0) := (others => '0');
	 signal r_xor : std_logic_vector(7 downto 0) := (others => '0');
	 signal r_sum : std_logic_vector(7 downto 0) := (others => '0');
	 
begin
-- external carry input
r_carry(0) <= su;
-- Array of full adders
full_adder_array: FOR j IN 0 TO 7 GENERATE
    Inst_full_adder: full_adder PORT MAP(
        a => a_data_i(j),
        b => r_xor(j),
        cin => r_carry(j),
        s => r_sum(j),
        cout => r_carry(j+1) -- connect cout to cin of the next FA
    );
	 r_xor(j) <= su XOR b_data_i(j);
END GENERATE full_adder_array;
s_data_obuf <= r_sum when (eu = '1') else (others => 'Z');
cout <= r_carry(8);
end rtl;

