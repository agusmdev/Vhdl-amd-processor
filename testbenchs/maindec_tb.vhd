library ieee;
use ieee.std_logic_1164.all;

entity maindec_tb is
end maindec_tb;

architecture Behavior of maindec_tb is

-- Input Signals
	signal Op  : std_logic_vector( 10 downto 0 );
-- Output Signals	
	signal Reg2Loc, ALUsrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch : std_logic;
   signal AluOp : std_logic_vector( 1 downto 0 ); 

begin
	dut: entity work.maindec 
	port map (
	Op => Op,
	Reg2Loc => Reg2Loc,
	ALUsrc => ALUsrc,
	MemtoReg => MemtoReg,
	RegWrite => RegWrite,
	MemRead => MemRead,
	MemWrite => MemWrite,
	Branch => Branch,
	AluOp => AluOp
	);
	
	test_proc: process
	begin
		Op <= "10001011000";
		wait for 20ns;
		assert (Reg2Loc = '0' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '1' and MemRead = '0' and MemWrite = '0' and Branch ='0' and AluOp = "10")  -- expected output
		report "test failed test for add instrucion" severity error;

		Op <= "11001011000";
		wait for 20ns;
		assert (Reg2Loc = '0' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '1' and MemRead = '0' and MemWrite = '0' and Branch ='0' and AluOp = "10")  -- expected output
		report "test failed test for sub instrucion" severity error;

		Op <= "10001010000";
		wait for 20ns;
		assert (Reg2Loc = '0' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '1' and MemRead = '0' and MemWrite = '0' and Branch ='0' and AluOp = "10")  -- expected output
		report "test failed test for and instrucion" severity error;
		
		Op <= "10101010000";
		wait for 20ns;
		assert (Reg2Loc = '0' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '1' and MemRead = '0' and MemWrite = '0' and Branch ='0' and AluOp = "10")  -- expected output
		report "test failed test for orr instrucion" severity error;

		Op <= "11111000010";
		wait for 20ns;
		assert (Reg2Loc = '0' and ALUsrc = '1' and MemtoReg = '1' and RegWrite = '1' and MemRead = '1' and MemWrite = '0' and Branch ='0' and AluOp = "00")  -- expected output
		report "test failed test for lw instrucion" severity error;

		Op <= "11111000000";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '1' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '1' and Branch ='0' and AluOp = "00")  -- expected output
		report "test failed test for sw instrucion" severity error;
		
		Op <= "10110100000";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;		
		
		
		Op <= "10110100001";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;	
		
		Op <= "10110100010";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;	
		
		Op <= "10110100011";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;	
		
		Op <= "10110100100";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;			
		
		Op <= "10110100101";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;	
		
		Op <= "10110100110";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;	
		
		Op <= "10110100111";
		wait for 20ns;
		assert (Reg2Loc = '1' and ALUsrc = '0' and MemtoReg = '0' and RegWrite = '0' and MemRead = '0' and MemWrite = '0' and Branch ='1' and AluOp = "01")  -- expected output
		report "test failed test for cbz instrucion" severity error;	
		
		wait;
	end process;
end;