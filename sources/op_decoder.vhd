-- OPCode decoder
-- opcode --> recieves MSN of current instruction
-- LDA --> LOAD A register
-- ADD --> ADD B to A
-- SUB --> SUBSTRACT B from A
-- OPT --> OUTPUT A register content
-- HLT --> HALT

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity op_decoder is
    Port ( opcode : in  STD_LOGIC_VECTOR (3 downto 0);
           LDA : out  STD_LOGIC;
           ADD : out  STD_LOGIC;
           SUB : out  STD_LOGIC;
           OPT : out  STD_LOGIC;
           HLT : out  STD_LOGIC);
end op_decoder;

architecture rtl of op_decoder is

begin
	LDA <= '1' when opcode = "0000" else '0';
	ADD <= '1' when opcode = "0001" else '0';
	SUB <= '1' when opcode = "0010" else '0';
	OPT <= '1' when opcode = "1110" else '0';
	HLT <= '1' when opcode = "1111" else '0';
end rtl;

