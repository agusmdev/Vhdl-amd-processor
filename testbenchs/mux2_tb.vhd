library ieee;
use ieee.std_logic_1164.all;

entity mux2_tb is
end mux2_tb;

architecture Behavior of mux2_tb is
constant MUX_WIDTH : integer := 64;
component mux2 is
	generic (N: integer := 64);
	port(	d0,d1 : 	in STD_LOGIC_VECTOR(N-1 downto 0);
			s : 		in STD_LOGIC;
			y : 		out STD_LOGIC_VECTOR(N-1 downto 0)
	 ); 
end component;

-- Input Signals
signal d0,d1 : std_logic_vector (MUX_WIDTH-1 downto 0);
signal s		 : std_logic;
-- Output Signals
signal y : std_logic_vector (MUX_WIDTH-1 downto 0);

begin
	dut: mux2 
	generic map (
		N => MUX_WIDTH)
	port map (
		d0 => d0,
		d1 => d1,
		s => s,
		y => y
	);
	test_proc: process
	begin
		d0 <=  x"0000000000000001";
		d1 <=  x"0000000000000003";
		s <= '0'; -- suma
		wait for 1ms;
		assert ((y = x"0000000000000001"))  -- expected output
		report "test failed for s = 0" severity error;
		s <= '1'; -- suma
		wait for 1ms;
		assert ((y = x"0000000000000003"))  -- expected output
		report "test failed for s = 1" severity error;
		wait;
	end process;
end;