library ieee;
use ieee.std_logic_1164.all;

entity aludec_tb is
end aludec_tb;

architecture Behavior of aludec_tb is
component aludec is
    port (
			 funct  : in std_logic_vector( 10 downto 0 ); --opcode
			 aluop  : in  std_logic_vector( 1 downto 0 );  
			 alucontrol : out std_logic_vector( 3 downto 0 )	 
			 );           
end component;

-- Input Signals
signal funct : std_logic_vector (10 downto 0);
signal aluop : std_logic_vector (1 downto 0);
-- Output Signals
signal alucontrol : std_logic_vector (3 downto 0);

begin
	dut: aludec
	port map (
		funct => funct,
		aluop => aluop,
		alucontrol => alucontrol
	);
	test_proc: process
	begin
		aluop <=  "00"; -- ldur/stur
		wait for 10ns;
		assert ((alucontrol = "0010"))  -- expected output
		report "test failed for ldur/stur innstruction" severity error;
	
		aluop <=  "01"; -- cbz
		wait for 10ns;
		assert ((alucontrol = "0111"))  -- expected output
		report "test failed for cbz innstruction" severity error;		

		aluop <=  "10"; -- R-type
		funct <= "10001011000"; --ADD
		wait for 10ns;
		assert ((alucontrol = "0010"))  -- expected output
		report "test failed for add innstruction" severity error;		

		aluop <=  "10"; -- R-type
		funct <= "11001011000"; --SUB
		wait for 10ns;
		assert ((alucontrol = "0110"))  -- expected output
		report "test failed for sub innstruction" severity error;		
		
		aluop <=  "10"; -- R-type
		funct <= "10001010000"; --AND
		wait for 10ns;
		assert ((alucontrol = "0000"))  -- expected output
		report "test failed for and innstruction" severity error;	
		
		aluop <=  "10"; -- R-type
		funct <= "10101010000"; --ORR
		wait for 10ns;
		assert ((alucontrol = "0001"))  -- expected output
		report "test failed for orr innstruction" severity error;			
		
		assert false report "End test" severity note;			
		wait;
	end process;
end;