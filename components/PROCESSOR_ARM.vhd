library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity processor_arm is
   generic (N: integer := 64);
    port (
   clk, reset, dump : in std_logic;
   IM_addr, DM_addr, DM_data : out std_logic_vector(63 downto 0);
   IM_data : out std_logic_vector (31 downto 0)
    );

end entity;

architecture behav of processor_arm is

signal reg2loc, regWrite, AluSrc, Branch,  memtoReg, memRead, memWrite: std_logic;
signal AluControl : std_logic_vector (3 downto 0);
signal IM_readData_s,
       IFID_IM_readData_s : std_logic_vector (31 downto 0);
signal DM_readData_s,
       IFID_IM_s: std_logic_vector (N-1 downto 0);
signal IM_addr_s,DM_addr_s, DM_writeData_s: std_logic_vector (N-1 downto 0);
signal DM_writeEnable_s : std_logic;

begin

datapath_0: entity work.datapath
  generic map (
    N => N)
  port map (
         reset => reset,
      clk => clk,
         reg2loc => reg2loc,
      regWrite => regWrite,
      AluSrc => AluSrc,
      Branch => Branch,
      memtoReg => memtoReg,
      memRead => memRead,
      memWrite => memWrite,
         AluControl => AluControl,
      IM_readData => IM_readData_s,
      DM_readData => DM_readData_s,
      IM_addr => IM_addr_s,
      DM_addr => DM_addr_s,
      DM_writeData => DM_writeData_s ,
         DM_writeEnable => DM_writeEnable_s
  );

controller_0 : entity work.controller
  port map (
        instr => IFID_IM_readData_s(31 downto 21),
        AluControl => AluControl,
        reg2loc => reg2loc,
      regWrite => regWrite,
      AluSrc => AluSrc,
      Branch => Branch,
      memtoReg => memtoReg,
      memRead => memRead,
      memWrite => memWrite
     );

imem_0: entity work.imem
  generic map (
    N => 32)
  port map (
    addr => IM_addr_s(7 downto 2),
    q => IM_readData_s
  );

dmem_0: entity work.dmem
  generic map (
    width => 64)
  port map (
      clk => clk,
      memWrite => DM_writeEnable_s,
      memRead => memRead,
      address => DM_addr_s(8 downto 3),
      writeData => DM_writeData_s,
      readData => DM_readData_s,
      dump => dump
  );

IF_ID: entity work.flopr
  generic map(
    N => 96)
  port map (
    d(95 downto 32) => IM_addr_s,
    d(31 downto 0) => IM_readData_s(31 downto 0),
    clk => clk,
    reset => reset,
    q(31 downto 0) => IFID_IM_readData_s(31 downto 0),
    -- TODO: Output to ID_EX
    --q(95 downto 32) => IM_readData_s(31 downto 0)
    q(95 downto 32) => IFID_IM_s
  );

IM_addr <= IM_addr_s;
IM_data <= IM_readData_s;
DM_addr <= DM_addr_s;
DM_data <= DM_readData_s;
end behav;
