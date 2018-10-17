library ieee;
use ieee.std_logic_1164.all;

entity signext_tb is
end signext_tb;

architecture Behavior of signext_tb is
constant SIGNEXT_WIDTH : integer := 64;
component signext is
	 generic (N: integer := 64);
    port (a : in std_logic_vector (31 downto 0);
          y : out std_logic_vector (N-1 downto 0)
			 );           
end component;

-- Input Signals
signal a : std_logic_vector (31 downto 0);
-- Output Signals
signal y : std_logic_vector (SIGNEXT_WIDTH-1 downto 0);

begin
	dut: signext
	generic map (
		N => SIGNEXT_WIDTH)
	port map (
		a => a,
		y => y
	);
	test_proc: process
	begin
		a <=  x"F8428020"; -- ldur x0,[x1,40]
		wait for 10ns;
		assert ((y = x"0000000000000028"))  -- expected output
		report "test failed for ldur innstruction" severity error;

		a <=  x"F8028020"; -- stur x0,[x1,40]
		wait for 10ns;
		assert ((y = x"0000000000000028"))  -- expected output
		report "test failed for stur innstruction" severity error;

		a <=  x"F85D8040"; -- ldur x0,[x1,-40]
		wait for 10ns;
		assert ((y = x"FFFFFFFFFFFFFFD8"))  -- expected output
		report "test failed for ldur innstruction (for negative inmmediate)" severity error;

		a <=  x"F81D8040"; -- stur x0,[x1,-40]
		wait for 10ns;
		assert ((y = x"FFFFFFFFFFFFFFD8"))  -- expected output
		report "test failed for stur innstruction (for negative inmmediate)" severity error;	
		
		a <=  x"B4000080"; -- cbz x0,8
		wait for 10ns;
		assert ((y = x"0000000000000004"))  -- expected output
		report "test failed for cbz innstruction" severity error;		

		a <=  x"B4FFFF80"; -- cbz x0,-8
		wait for 10ns;
		assert ((y = x"FFFFFFFFFFFFFFFC"))  -- expected output
		report "test failed for cbz innstruction (for negative inmmediate)" severity error;		
		
		assert false report "End test" severity note;	

		wait;
	end process;
end;