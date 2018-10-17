library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture Behavior of alu_tb is
constant ALU_WIDTH : integer := 64;
component alu is
	 generic (N: integer := 64);
    port (a,b : in std_logic_vector (N-1 downto 0);
          alucontrol : in std_logic_vector (3 downto 0);
          result : out std_logic_vector (N-1 downto 0);
          zero : out std_logic);           
end component;

-- Input Signals
signal a,b : std_logic_vector (ALU_WIDTH-1 downto 0);
signal alucontrol : std_logic_vector (3 downto 0);
-- Output Signals
signal result : std_logic_vector (ALU_WIDTH-1 downto 0);
signal zero		 : std_logic;

begin
	dut: alu 
	generic map (
		N => ALU_WIDTH)
	port map (
		a => a,
		b => b,
		alucontrol => alucontrol,
		result => result,
		zero => zero
	);
	test_proc: process
	begin
		a <=  x"0000000000000005";
		b <=  x"0000000000000003";
		alucontrol <= "0000"; -- and
		wait for 10ns;
		assert ((result = x"0000000000000001") and (zero = '0'))  -- expected output
		report "test failed for and operation" severity error;

		alucontrol <= "0001"; -- or
		wait for 10ns;
		assert ((result = x"0000000000000007") and (zero = '0'))  -- expected output
		report "test failed for or operation" severity error;

		alucontrol <= "0010"; -- add
		wait for 10ns;
		assert ((result = x"0000000000000008") and (zero = '0'))  -- expected output
		report "test failed for and operation" severity error;

		alucontrol <= "0110"; -- sub
		wait for 10ns;
		assert ((result = x"0000000000000002") and (zero = '0'))  -- expected output
		report "test failed for sub operation" severity error;

		alucontrol <= "0111"; -- pass input b
		wait for 10ns;
		assert ((result = x"0000000000000003") and (zero = '0'))  -- expected output
		report "test failed for pass input b operation" severity error;
		
		alucontrol <= "1100"; -- not or
		wait for 10ns;
		assert ((result = x"FFFFFFFFFFFFFFF8") and (zero = '0'))  -- expected output
		report "test failed for not or operation" severity error;		

		a <=  x"0000000000000003";
		b <=  x"0000000000000003";
		alucontrol <= "0110"; -- sub for zero result
		wait for 10ns;
		assert ((result = x"0000000000000000") and (zero = '1'))  -- expected output
		report "test failed for sub (zero result) operation" severity error;
	
		wait;
	end process;
end;