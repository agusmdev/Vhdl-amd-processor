library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;


entity datapath is
   generic (N: integer := 64);
    port (
         reset, clk :in  std_logic;
         nonzBr, reg2loc, regWrite, AluSrc, Branch,  memtoReg, memRead, memWrite: in std_logic;
         AluControl : in std_logic_vector (3 downto 0);
         IM_readData : in std_logic_vector (31 downto 0);
         DM_readData: in std_logic_vector (N-1 downto 0);
         IM_addr,DM_addr, DM_writeData: out std_logic_vector (N-1 downto 0);
         DM_writeEnable, DM_readEnable : out std_logic
       );
end entity;


architecture behav of datapath is

--- Signals
signal PCSrc, zero: std_logic;
signal PCBranch,writeData_D,signImm, PC, DM_readData_s : std_logic_vector(N-1 downto 0);
signal readData1,readData2, aluResult,writeData_E : std_logic_vector(N-1 downto 0);
-- IF_ID
signal IFID_IM_readData_s : std_logic_vector (31 downto 0);
signal IFID_IM_addr_s : std_logic_vector (N-1 downto 0);
-- ID_EX
signal IDEX_nonzBr, IDEX_reg2loc, IDEX_regWrite, IDEX_AluSrc, IDEX_Branch,
     IDEX_memtoReg, IDEX_memRead, IDEX_memWrite: std_logic;
signal  IDEX_AluControl : std_logic_vector (3 downto 0);
signal  IDEX_instr : std_logic_vector (4 downto 0);
signal  IDEX_readData2_E,
        IDEX_readData1_E,
        IDEX_signImm_E,
        IDEX_PC_E : std_logic_vector (n-1 downto 0);
-- EX_MEM
signal EXMEM_nonzBr, EXMEM_reg2loc, EXMEM_regWrite, EXMEM_Branch,
     EXMEM_memtoReg, EXMEM_memRead, EXMEM_memWrite: std_logic;
signal  EXMEM_writeData_E,
        EXMEM_aluResult_E,
        EXMEM_PCBranch_E : std_logic_vector(n-1 downto 0);
signal  EXMEM_zero_E : std_logic;
signal  EXMEM_instr : std_logic_vector (4 downto 0);
--MEM_WB
signal  MEMWB_instr : std_logic_vector (4 downto 0);
signal  MEMWB_readData,
        MEMWB_aluresult_E: std_logic_vector(n-1 downto 0);
signal  MEMWB_memtoReg,
        MEMWB_regWrite: std_logic;
--Hazard unit
signal IFID_enable, PC_write: std_logic;
signal reg_rn_s: std_logic_vector(4 downto 0);
signal control_signals: std_logic_vector(11 downto 1);
signal new_control: std_logic_vector(11 downto 1);

begin
--control
    control_signals(1) <= memtoReg;
    control_signals(2) <= regWrite;
    control_signals(3) <= memWrite;
    control_signals(4) <= memRead;
    control_signals(5) <= Branch;
    control_signals(9 downto 6) <= aluControl;
    control_signals(10) <= aluSrc;
    control_signals(11) <= nonzBr;
-- Fetch inst
  fetch_0: entity work.fetch
  generic map (
    N => N)
  port map (
    PCSrc_F => PCSrc,
    clk => clk,
    reset => reset,
    IFID_enable => IFID_enable,
    PCBranch_F => EXMEM_PCBranch_E,
    imem_addr_F => PC
  );

-- Decode Inst
  decode_0: entity work.decode
  generic map (
    N => N)
  port map (
    regWrite_D => MEMWB_regWrite,
    reg2loc_D => reg2loc,
    clk => clk,
    writeData3_D => writeData_D,
    instr_D => IFID_IM_readData_s,
    wa3_D => MEMWB_instr,
    signImm_D => signImm,
    readData1_D => readData1,
    readData2_D => readData2,
    reg_rn => reg_rn_s
  );

-- Excecute
  execute_0: entity work.execute
  generic map (
    N => N)
  port map (
    aluSrc => IDEX_aluSrc,
    aluControl => IDEX_aluControl,
    PC_E => IDEX_PC_E,
    SignImm_E => IDEX_signImm_E,
    readData1_E => IDEX_readData1_E,
    readData2_E => IDEX_readData2_E,
    PCBranch_E => PCBranch,
    aluResult_E => aluResult,
    writeData_E => writeData_E,
    zero_E => zero
  );

-- Memory
DM_addr <= EXMEM_aluResult_E;
DM_writeData <= EXMEM_writeData_E;
DM_writeEnable <= EXMEM_memWrite;
DM_readEnable <= EXMEM_memRead;
DM_readData_s <= DM_readData;
memory_0: entity work.memory
    port map (
   Branch => EXMEM_Branch,
   nonzBr => EXMEM_nonzBr,
   zero => EXMEM_zero_E,
    PCSrc => PCSrc
   );

-- Writeback

writeback_0: entity work.writeback
    port map (
   aluResult => MEMWB_aluresult_E,
   DM_readData => MEMWB_readData,
   memtoReg => MEMWB_memtoReg,
    writeData => writeData_D
   );

IF_ID: entity work.flopre
  generic map(
    N => 96)
  port map (
    d(95 downto 32) => PC,
    d(31 downto 0) => IM_readData,
    clk => clk,
    reset => reset,
    enable => IFID_enable,
    q(31 downto 0) => IFID_IM_readData_s,
    q(95 downto 32) => IFID_IM_addr_s
  );

ID_EX: entity work.flopr
  generic map(
    N => 272)
  port map (
    d(4 downto 0) => IFID_IM_readData_s(4 downto 0),
    d(68 downto 5) => readData2,
    d(132 downto 69) => readData1,
    d(196 downto 133) => signImm,
    d(260 downto 197) => IFID_IM_addr_s,
    d(261) => new_control (1),
    d(262) => new_control (2),
    d(263) => new_control (3),
    d(264) => new_control (4),
    d(265) => new_control (5),
    d(269 downto 266) => new_control  (9 downto 6),
    d(270) => new_control (10),
    d(271) => new_control (11),
    clk => clk,
    reset => reset,
    q(4 downto 0) => IDEX_instr,
    q(68 downto 5) => IDEX_readData2_E,
    q(132 downto 69) => IDEX_readData1_E,
    q(196 downto 133) => IDEX_signImm_E,
    q(260 downto 197) => IDEX_PC_E,
    q(261) => IDEX_memtoReg,
    q(262) => IDEX_regWrite,
    q(263) => IDEX_memWrite,
    q(264) => IDEX_memRead,
    q(265) => IDEX_Branch,
    q(269 downto 266) => IDEX_aluControl,
    q(270) => IDEX_aluSrc,
    q(271) => IDEX_nonzBr
  );

  EX_MEM: entity work.flopr
  generic map(
    N => 204)
  port map (
    d(4 downto 0) => IDEX_instr,
    d(68 downto 5) => writeData_E,
    d(132 downto 69) => aluResult,
    d(133) => zero,
    d(197 downto 134) => PCBranch,
    d(198) => IDEX_memtoReg,
    d(199) => IDEX_regWrite,
    d(200) => IDEX_memWrite,
    d(201) => IDEX_memRead,
    d(202) => IDEX_Branch,
    d(203) => IDEX_nonzBr,
    clk => clk,
    reset => reset,
    q(4 downto 0) => EXMEM_instr,
    q(68 downto 5) => EXMEM_writeData_E,
    q(132 downto 69) => EXMEM_aluResult_E,
    q(133) => EXMEM_zero_E,
    q(197 downto 134) => EXMEM_PCBranch_E,
    q(198) => EXMEM_memtoReg,
    q(199) => EXMEM_regWrite,
    q(200) => EXMEM_memWrite,
    q(201) => EXMEM_memRead,
    q(202) => EXMEM_Branch,
    q(203) => EXMEM_nonzBr
  );


MEM_WB: entity work.flopr
  generic map(
    N => 135)
  port map (
    d(4 downto 0) => EXMEM_instr,
    d(68 downto 5) => DM_readData_s,
    d(132 downto 69) => EXMEM_aluResult_E,
    d(133) => EXMEM_memtoReg,
    d(134) => EXMEM_regWrite,
    clk => clk,
    reset => reset,
    q(4 downto 0) => MEMWB_instr,
    q(68 downto 5) => MEMWB_readData,
    q(132 downto 69) => MEMWB_aluresult_E,
    q(133) => MEMWB_memtoReg,
    q(134) => MEMWB_regWrite
  );

  hazard_unit: entity work.hazard_detection_unit
  generic map(
    N => 32)
  port map (
      ID_EX_MemRead => IDEX_memWrite,
      ID_EX_RegWrite => IDEX_regWrite,
      EX_MEM_MemRead => EXMEM_memRead,
      EX_MEM_RegWrite => EXMEM_regWrite,
      IF_ID_branch => new_control(5),
      IF_ID_RegisterRm => reg_rn_s,
      IF_ID_RegisterRd => IFID_IM_readData_s(4 downto 0),
      IF_ID_RegisterRn => IFID_IM_readData_s(9 downto 5),
      ID_EX_RegisterRd => IDEX_instr,
      EX_MEM_RegisterRd => EXMEM_instr,
      clk => clk,
      enable => IFID_enable
  );

  control_mux: entity work.mux2
  generic map(
    N => 11)
  port map (
      d0 => "00000000000",
      d1 => control_signals,
      s => IFID_enable,
      y => new_control 
  );

-- Other
IM_addr <= PC;

end architecture;
