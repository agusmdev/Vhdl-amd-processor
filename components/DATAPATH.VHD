library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;


entity datapath is
	 generic (N: integer := 64);
    port (
         reset, clk :in  std_logic;
         reg2loc, regWrite, AluSrc, Branch,  memtoReg, memRead, memWrite: in std_logic;
         AluControl : in std_logic_vector (3 downto 0);
			IM_readData : in std_logic_vector (31 downto 0);
			DM_readData: in std_logic_vector (N-1 downto 0);
			IM_addr,DM_addr, DM_writeData: out std_logic_vector (N-1 downto 0);
         DM_writeEnable : out std_logic
       );
end entity;


architecture behav of datapath is

--- Signals
signal PCSrc, zero: std_logic;
signal PCBranch,writeData_D,signImm, PC, DM_readData_s : std_logic_vector(N-1 downto 0);
signal readData1,readData2, aluResult,writeData_E : std_logic_vector(N-1 downto 0);


begin

-- Fetch inst
	fetch_0: entity work.fetch 
	generic map (
		N => N)
	port map (
		PCSrc_F => PCSrc,
		clk => clk,
		reset => reset,
		PCBranch_F => PCBranch,
		imem_addr_F => PC
	);
	
-- Decode Inst
	decode_0: entity work.decode 
	generic map (
		N => N)
	port map (
		regWrite_D => regWrite,
		reg2loc_D => reg2loc,
		clk => clk,
		writeData3_D => writeData_D,
		instr_D => IM_readData,
		signImm_D => signImm,
		readData1_D => readData1,
		readData2_D => readData2	
	);
	
-- Excecute
	execute_0: entity work.execute 
	generic map (
		N => N)
	port map (
		aluSrc => aluSrc,
		aluControl => aluControl,
		PC_E => PC,
		SignImm_E => SignImm,
		readData1_E => readData1,
		readData2_E => readData2,
		PCBranch_E => PCBranch,
		aluResult_E => aluResult,
		writeData_E => writeData_E,	
		zero_E => zero	
	);

-- Memory
DM_addr <= aluResult;
DM_writeData <= writeData_E;
DM_writeEnable <= memWrite;
DM_readData_s <= DM_readData;
memory_0: entity work.memory
    port map (
	 Branch => Branch, 
	 zero => zero,
    PCSrc => PCSrc
	 );

-- Writeback

writeback_0: entity work.writeback 
    port map (
	 aluResult => aluResult,
	 DM_readData => DM_readData_s,
	 memtoReg => memtoReg,
    writeData => writeData_D
	 );

-- Other 
IM_addr <= PC;

end architecture;
