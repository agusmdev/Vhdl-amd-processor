library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile_tb is
end regfile_tb;

architecture Behavior of regfile_tb is

constant REGFILE_WIDTH : integer := 64;
constant CLK_PERIOD : time := 20 ns;

-- Input Signals
signal ra1, ra2, wa3: std_logic_vector (4 downto 0);
signal wd3: std_logic_vector (63 downto 0);
signal clk, we3, finish: std_logic := '0';
-- Output Signals
signal rd1, rd2: std_logic_vector (63 downto 0);

begin
	dut: entity work.regfile 
	port map (
			ra1 => ra1, 
			ra2 => ra2, 
			wa3 => wa3,
			wd3 => wd3,
			clk => clk,
			we3 => we3,
			rd1 => rd1,
			rd2 => rd2
	);
	
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal

	
	test_proc: process
	begin
		-- Write Data
		we3 <= '1';
		for ad in 0 to 31 loop
			wd3 <= std_logic_vector(to_UNSIGNED(ad,64));
			wa3 <=  std_logic_vector(to_UNSIGNED(ad,5));
			wait for CLK_PERIOD;
		end loop;	
		-- Read Data
		wait for CLK_PERIOD;
		we3 <= '0';
		wait for CLK_PERIOD;		
		for ad in 0 to 30 loop
			ra1 <=  std_logic_vector(to_UNSIGNED(ad,5));
			ra2 <=  std_logic_vector(to_UNSIGNED(ad,5));			
			wait for CLK_PERIOD/2;
			assert (rd1 =  std_logic_vector(to_UNSIGNED(ad,64))) -- expected output
			report "test failed for rd1" severity error;		
			assert (rd2 =  std_logic_vector(to_UNSIGNED(ad,64))) -- expected output
			report "test failed for rd2" severity error;					
			wait for CLK_PERIOD/2;	
		end loop;
		-- Test X31 is 0
		ra1 <= "11111";
		wait for CLK_PERIOD/2;
		assert (rd1 =  x"0000000000000000") -- expected output
		report "test failed, X31 is diferent to 0" severity error;		
		wait for CLK_PERIOD/2;	
		finish <= '1';
		wait;
	end process;
end;