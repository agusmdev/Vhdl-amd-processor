library ieee;
use ieee.std_logic_1164.all;

entity adder_tb is
end adder_tb;

architecture Behavior of adder_tb is
constant ADDER_WIDTH : integer := 64;
component adder is
	generic (N: integer := 64);
	port(	a,b : 	in STD_LOGIC_VECTOR(N-1 downto 0);
			y : 		out STD_LOGIC_VECTOR(N-1 downto 0)
	 ); 
end component;

-- Input Signals
signal a,b : std_logic_vector (ADDER_WIDTH-1 downto 0);
-- Output Signals
signal y : std_logic_vector (ADDER_WIDTH-1 downto 0);

begin
	dut: adder
	generic map (
		N => ADDER_WIDTH)
	port map (
		a => a,
		b => b,
		y => y
	);
	test_proc: process
	begin
		a <=  x"0000000000000001";
		b <=  x"0000000000000003";
		wait for 1ms;
		assert ((y = x"0000000000000004"))  -- expected output
		report "test failed for 1 + 3" severity error;
		a <=  x"0000000000000001";
		b <=  x"FFFFFFFFFFFFFFFF";
		wait for 1ms;
		assert ((y = x"0000000000000000"))  -- expected output
		report "test failed for 1 - 1" severity error;
		wait;
	end process;
end;