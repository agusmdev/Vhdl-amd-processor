library ieee;
use ieee.std_logic_1164.all;

entity fetch_tb is
end fetch_tb;

architecture Behavior of fetch_tb is
constant FETCH_WIDTH : integer := 64;
constant CLK_PERIOD : time := 20 ns;

-- Input Signals
signal PCSrc_F,clk, reset,finish: std_logic := '0';
signal PCBranch_F: std_logic_vector(FETCH_WIDTH-1 downto 0);
-- Output Signals
signal imem_addr_F: std_logic_vector(FETCH_WIDTH-1 downto 0);


begin
	dut: entity work.fetch 
	generic map (
		N => FETCH_WIDTH)
	port map (
		PCSrc_F => PCSrc_F,
		clk => clk,
		reset => reset,
		PCBranch_F => PCBranch_F,
		imem_addr_F => imem_addr_F
	);
	
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal

	
	test_proc: process
	begin
		reset <= '1';
		PCBranch_F <= x"000000000000FFFF";
		PCSrc_F <= '0';
		wait for CLK_PERIOD;
		assert (imem_addr_F = x"0000000000000000")  -- expected output
		report "test failed: reset" severity error;

		reset <= '0';
		wait for CLK_PERIOD;
		assert (imem_addr_F = x"0000000000000004")  -- expected output
		report "test failed: plus 4 adder (4)" severity error;	

		wait for CLK_PERIOD;
		assert (imem_addr_F = x"0000000000000008")  -- expected output
		report "test failed: plus 4 adder (8)" severity error;	
		
		wait for CLK_PERIOD;
		assert (imem_addr_F = x"000000000000000C")  -- expected output
		report "test failed: plus 4 adder (C)" severity error;	
		
		wait for CLK_PERIOD;
		assert (imem_addr_F = x"0000000000000010")  -- expected output
		report "test failed: plus 4 adder (10)" severity error;	
		
		PCSrc_F <= '1';		
		wait for CLK_PERIOD;
		assert (imem_addr_F = x"000000000000FFFF")  -- expected output
		report "test failed: branch" severity error;	
		
		finish <= '1';
		wait;
	end process;
end;