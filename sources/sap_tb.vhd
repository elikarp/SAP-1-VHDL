--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   07:22:35 10/23/2018
-- Design Name:   
-- Module Name:   C:/Users/Elikarp/Documents/FPGA/ISE Projects/SAP_1/sap_tb.vhd
-- Project Name:  SAP_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SAP_1_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY sap_tb IS
END sap_tb;
 
ARCHITECTURE behavior OF sap_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SAP_1_top
    PORT(
         clk100MHz : IN  std_logic;
         pulse_btn_i : IN  std_logic;
         data_sw_i : IN  std_logic_vector(7 downto 0);
         addr_sw_i : IN  std_logic_vector(3 downto 0);
         clr_btn_i : IN  std_logic;
         we_btn_i : IN  std_logic;
         RP_sw_i : IN  std_logic;
         AM_sw_i : IN  std_logic;
         data_ld_o : OUT  std_logic_vector(7 downto 0);
         addr_ld_o : OUT  std_logic_vector(3 downto 0);
         cout_ld_o : OUT  std_logic;
         RP_ld_o : OUT  std_logic;
         AM_ld_o : OUT  std_logic;
         HLT_ld_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk100MHz : std_logic := '0';
   signal pulse_btn_i : std_logic := '0';
   signal data_sw_i : std_logic_vector(7 downto 0) := (others => '0');
   signal addr_sw_i : std_logic_vector(3 downto 0) := (others => '0');
   signal clr_btn_i : std_logic := '0';
   signal we_btn_i : std_logic := '0';
   signal RP_sw_i : std_logic := '0';
   signal AM_sw_i : std_logic := '0';

 	--Outputs
   signal data_ld_o : std_logic_vector(7 downto 0);
   signal addr_ld_o : std_logic_vector(3 downto 0);
   signal cout_ld_o : std_logic;
   signal RP_ld_o : std_logic;
   signal AM_ld_o : std_logic;
   signal HLT_ld_o : std_logic;

   -- Clock period definitions
   constant clk100MHz_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SAP_1_top PORT MAP (
          clk100MHz => clk100MHz,
          pulse_btn_i => pulse_btn_i,
          data_sw_i => data_sw_i,
          addr_sw_i => addr_sw_i,
          clr_btn_i => clr_btn_i,
          we_btn_i => we_btn_i,
          RP_sw_i => RP_sw_i,
          AM_sw_i => AM_sw_i,
          data_ld_o => data_ld_o,
          addr_ld_o => addr_ld_o,
          cout_ld_o => cout_ld_o,
          RP_ld_o => RP_ld_o,
          AM_ld_o => AM_ld_o,
          HLT_ld_o => HLT_ld_o
        );

   -- Clock process definitions
   clk100MHz_process :process
   begin
		clk100MHz <= '0';
		wait for clk100MHz_period/2;
		clk100MHz <= '1';
		wait for clk100MHz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- insert stimulus here 
		-- LDA EH
		addr_sw_i <= "0000";
		data_sw_i <= "00001110";
		wait for 10 ns;
		we_btn_i <= '1';
		wait for 10 ns;
		we_btn_i <= '0';
		wait for 20 ns;
		-- ADD FH
		addr_sw_i <= "0001";
		data_sw_i <= "00011111";
		wait for 10 ns;
		we_btn_i <= '1';
		wait for 10 ns;
		we_btn_i <= '0';
		wait for 20 ns;
		-- OPT
		addr_sw_i <= "0010";
		data_sw_i <= "11100000";
		wait for 10 ns;
		we_btn_i <= '1';
		wait for 10 ns;
		we_btn_i <= '0';
		wait for 20 ns;
		-- HLT
		addr_sw_i <= "0000";
		data_sw_i <= "00001110";
		wait for 10 ns;
		we_btn_i <= '1';
		wait for 10 ns;
		we_btn_i <= '0';
		wait for 20 ns;
		-- 1H
		addr_sw_i <= "1110";
		data_sw_i <= "00000001";
		wait for 10 ns;
		we_btn_i <= '1';
		wait for 10 ns;
		we_btn_i <= '0';
		wait for 20 ns;
		-- 2H
		addr_sw_i <= "1111";
		data_sw_i <= "00000010";
		wait for 10 ns;
		we_btn_i <= '1';
		wait for 10 ns;
		we_btn_i <= '0';
		wait for 20 ns;
		
		RP_sw_i <= '1';
		AM_sw_i <= '1';
		wait for 10 ns;

      wait;
   end process;

END;
