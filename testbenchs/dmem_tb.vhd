library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dmem_tb is
end dmem_tb;

architecture Behavior of dmem_tb is

constant DMEM_WIDTH : integer := 64;
constant CLK_PERIOD : time := 20 ns;

-- Input Signals
signal clk,finish : std_logic:= '0';
signal memWrite, memRead: STD_LOGIC;
signal address, writeData: STD_LOGIC_VECTOR(DMEM_WIDTH-1 downto 0);
signal dump: STD_LOGIC;
-- Output Signals
signal readData: STD_LOGIC_VECTOR(DMEM_WIDTH-1 downto 0);
		 
begin
	dut: entity work.dmem 
	generic map (
		width => DMEM_WIDTH)
	port map (
			clk => clk,
			memWrite => memWrite, 
			memRead => memRead,
			address => address,
			writeData => writeData,
			readData => readData,
			dump => dump
	);
	
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal

	
	test_proc: process
	begin
	
		-- Write Data
		memWrite <= '1';
		memRead <= '0';
		dump <= '0';
		for ad in 0 to 63 loop
			writeData <= std_logic_vector(to_UNSIGNED(ad,64));
			address <=  std_logic_vector(to_UNSIGNED(ad,64));
			wait for CLK_PERIOD;
		end loop;	
		-- Read Data
		memWrite <= '0';
		memRead <= '1';		
		for ad in 0 to 63 loop
			address <=  std_logic_vector(to_UNSIGNED(ad,64));
			wait for CLK_PERIOD;
		end loop;
		dump <= '1';
		finish <= '1';
		wait;
	end process;
end;