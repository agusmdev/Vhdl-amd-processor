library ieee;
use ieee.std_logic_1164.all;

entity decode_tb is
end decode_tb;

architecture Behavior of decode_tb is

constant DECODE_WIDTH : integer := 64;
constant CLK_PERIOD : time := 20 ns;

-- Input Signals
signal regWrite_D, reg2loc_D: std_logic;
signal clk, finish: std_logic := '0';
signal writeData3_D: std_logic_vector(DECODE_WIDTH-1 downto 0);
signal instr_D: std_logic_vector(31 downto 0);
-- Output Signals
signal signImm_D, readData1_D, readData2_D: std_logic_vector(DECODE_WIDTH-1 downto 0);


begin
	dut: entity work.decode 
	generic map (
		N => DECODE_WIDTH)
	port map (
		regWrite_D => regWrite_D,
		reg2loc_D => reg2loc_D,
		clk => clk,
		writeData3_D => writeData3_D,
		instr_D => instr_D,
		signImm_D => signImm_D,
		readData1_D => readData1_D,
		readData2_D => readData2_D	
	);
	
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal

	
	test_proc: process
	begin
		-- Write 2 registers (ToDo: Use loop structure)
		regWrite_D <= '1';
		reg2loc_D <= '1';
		writeData3_D <= x"0000000000000001";
		instr_D <= x"8B010000"; -- ADD X0,X0,X0
		wait for CLK_PERIOD;
		writeData3_D <= x"0000000000000002";
		instr_D <= x"8B010001"; -- ADD X1,X0,X0
		wait for CLK_PERIOD;	
		
		-- Read the registers (ToDo: Use loop structure)
		regWrite_D <= '0';
		reg2loc_D <= '0';		
		wait for CLK_PERIOD;			
		assert ((readData1_D = x"0000000000000001") and (readData2_D = x"0000000000000002"))  -- expected output
		report "test failed" severity error;

		
		finish <= '1';
		wait;
	end process;
end;