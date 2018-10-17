library ieee;
use ieee.std_logic_1164.all;

entity imem_tb is
end imem_tb;

architecture Behavior of imem_tb is

constant IMEM_WIDTH : integer := 32;

-- Input Signals
signal addr : std_logic_vector (5 downto 0);
-- Output Signals
signal q : std_logic_vector (IMEM_WIDTH-1 downto 0);

begin
	dut: entity work.imem 
	generic map (
		N => IMEM_WIDTH)
	port map (
		addr => addr,
		q => q
	);
	test_proc: process
	begin
		addr <=  "000000";
		wait for 1ns;
		assert (q = x"f8000000")  -- expected output
		report "test failed for addr = 0" severity error;		
		
		addr <=  "000001";
		wait for 1ns;
		assert (q = x"f8008001")  -- expected output
		report "test failed for addr = 1" severity error;		
		
		addr <=  "000010";
		wait for 1ns;
		assert (q = x"f8010002")  -- expected output
		report "test failed for addr = 2" severity error;		
		
		addr <=  "000011";
		wait for 1ns;
		assert (q = x"f8018003")  -- expected output
		report "test failed for addr = 3" severity error;		
		
		addr <=  "000100";
		wait for 1ns;
		assert (q = x"f8020004")  -- expected output
		report "test failed for addr = 4" severity error;		
		
		addr <=  "000101";
		wait for 1ns;
		assert (q = x"f8028005")  -- expected output
		report "test failed for addr = 5" severity error;		
		
		addr <=  "000110";
		wait for 1ns;
		assert (q = x"f8030006")  -- expected output
		report "test failed for addr = 6" severity error;		
		
		addr <=  "000111";
		wait for 1ns;
		assert (q = x"f8400007")  -- expected output
		report "test failed for addr = 7" severity error;		
		
		addr <=  "001000";
		wait for 1ns;
		assert (q = x"f8408008")  -- expected output
		report "test failed for addr = 8" severity error;		
		
		addr <=  "001001";
		wait for 1ns;
		assert (q = x"f8410009")  -- expected output
		report "test failed for addr = 9" severity error;		
		
		addr <=  "001010";
		wait for 1ns;
		assert (q = x"f841800a")  -- expected output
		report "test failed for addr = 10" severity error;		
		
		addr <=  "001011";
		wait for 1ns;
		assert (q = x"f842000b")  -- expected output
		report "test failed for addr = 11" severity error;		
		
		addr <=  "001100";
		wait for 1ns;
		assert (q = x"f842800c")  -- expected output
		report "test failed for addr = 12" severity error;		
		
		addr <=  "001101";
		wait for 1ns;
		assert (q = x"f843000d")  -- expected output
		report "test failed for addr = 13" severity error;		
		
		addr <=  "001110";
		wait for 1ns;
		assert (q = x"cb0e01ce")  -- expected output
		report "test failed for addr = 14" severity error;		
		
		addr <=  "001111";
		wait for 1ns;
		assert (q = x"b400004e")  -- expected output
		report "test failed for addr = 15" severity error;		
		
		addr <=  "010000";
		wait for 1ns;
		assert (q = x"cb01000f")  -- expected output
		report "test failed for addr = 16" severity error;		
		
		addr <=  "010001";
		wait for 1ns;
		assert (q = x"8b01000f")  -- expected output
		report "test failed for addr = 17" severity error;		
		
		addr <=  "010010";
		wait for 1ns;
		assert (q = x"f803800f")  -- expected output
		report "test failed for addr = 18" severity error;				
		
		assert false report "fin del test" severity note;
		wait;
	end process;
end;