library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity sl2_tb is
end sl2_tb;

architecture Behavior of sl2_tb is
constant SL_WIDTH : integer := 64;
component sl2 is
	generic (width: integer := 64);
   port (a : in std_logic_vector (width-1 downto 0);
         y : out std_logic_vector (width-1 downto 0)); 
end component;

-- Input Signals
signal a : std_logic_vector (SL_WIDTH-1 downto 0);
-- Output Signals
signal y : std_logic_vector (SL_WIDTH-1 downto 0);

begin
	dut: sl2 
	generic map (
		width => SL_WIDTH)
	port map (
		a => a,
		y => y
	);
	test_proc: process
	begin
		a <=  x"0000000000000001";
		wait for 1ms;
		assert ((y = x"0000000000000004"))  -- expected output
		report "test failed" severity error;
		a <=  x"FFFFFFFFFFFFFFFF";		
		wait for 1ms;
		assert ((y = x"FFFFFFFFFFFFFFFC"))  -- expected output
		report "test failed" severity error;
		wait;
	end process;
end;