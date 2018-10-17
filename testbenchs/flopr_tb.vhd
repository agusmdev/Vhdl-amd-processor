library ieee;
use ieee.std_logic_1164.all;

entity flopr_tb is
end flopr_tb;

architecture Behavior of flopr_tb is

constant FLOPR_WIDTH : integer := 64;
constant CLK_PERIOD : time := 20 ns;

component flopr is
    generic ( N : integer := 64 );             
port (
     q		:out std_logic_vector( N-1 downto 0 );
     d		:in  std_logic_vector( N-1 downto 0 );               
     clk		:in  std_logic;                  
     reset	:in  std_logic                   
   );
end component;

-- Input Signals
signal q 			: std_logic_vector (FLOPR_WIDTH-1 downto 0);
signal clk,finish : std_logic:= '0';
signal reset		: std_logic:= '1';
-- Output Signals
signal d 			: std_logic_vector (FLOPR_WIDTH-1 downto 0);

begin
	dut: flopr 
	generic map (
		N => FLOPR_WIDTH)
	port map (
		q => q,
		d => d,
		clk => clk,
		reset => reset
	);
	clk <= not clk after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal
	test_proc: process
	begin
		d <=  x"000000000000000F";
		reset <= '1'; 
		wait for 20ns;
		assert (q = x"0000000000000000")  -- expected output
		report "test failed for reset = 1" severity error;
		
		reset <= '0'; 
		wait for 20ns;
		assert (q = x"000000000000000F")  -- expected output
		report "test failed for reset = 0" severity error;
		finish <= '1';
		wait;
	end process;
end;