library ieee;
use ieee.std_logic_1164.all;

entity execute_tb is
end execute_tb;

architecture Behavior of execute_tb is

constant EXECUTE_WIDTH : integer := 64;

-- Input Signals
signal aluSrc: std_logic;
signal aluControl: std_logic_vector(3 downto 0);
signal PC_E, SignImm_E: std_logic_vector(EXECUTE_WIDTH-1 downto 0);
signal readData1_E, readData2_E: std_logic_vector(EXECUTE_WIDTH-1 downto 0);
-- Output Signals
signal PCBranch_E, aluResult_E:  std_logic_vector(EXECUTE_WIDTH-1 downto 0);
signal writeData_E : std_logic_vector(EXECUTE_WIDTH-1 downto 0);
signal zero_E : std_logic;

begin
	dut: entity work.execute 
	generic map (
		N => EXECUTE_WIDTH)
	port map (
		aluSrc => aluSrc,
		aluControl => aluControl,
		PC_E => PC_E,
		SignImm_E => SignImm_E,
		readData1_E => readData1_E,
		readData2_E => readData2_E,
		PCBranch_E => PCBranch_E,
		aluResult_E => aluResult_E,
		writeData_E => writeData_E,	
		zero_E => zero_E	
	);
	
	
	test_proc: process
	begin
		-- Test branch adder
		PC_E <= x"0000000000000004";
		SignImm_E <= x"0000000000000001";
		-- Test ALU
		readData1_E <= x"0000000000000005";
		readData2_E <= x"0000000000000003";
		aluControl <= "0010";
		aluSrc <= '1';
		
		wait for 20ns;
		-- assert branch adder
		assert (PCBranch_E = x"0000000000000008")  -- expected output
		report "test failed: branch adder" severity error;
		--assert alu
		assert ((aluResult_E = x"0000000000000006") and (zero_E = '0')) -- expected output
		report "test failed: ALU inmm" severity error;
		aluSrc <= '0';
		wait for 20ns;
		assert ((aluResult_E = x"0000000000000008") and (zero_E = '0')) -- expected output
		report "test failed: ALU registers" severity error;
		assert (writeData_E = readData2_E) -- expected output
		report "test failed: WriteData" severity error;		
		wait;
	end process;
end;