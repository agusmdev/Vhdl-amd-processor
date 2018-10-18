library ieee;
use ieee.std_logic_1164.all;

entity controller is
port (
        instr : in std_logic_vector(10 downto 0);
        AluControl : out std_logic_vector(3 downto 0);
        nonzBr, reg2loc, regWrite, AluSrc, Branch,  memtoReg, memRead, memWrite : out std_logic
     );
end entity;

architecture cont of controller is

signal funct : std_logic_vector (10 downto 0);
signal aluop : std_logic_vector (1 downto 0);

begin

maindec_0: entity work.maindec
	port map (
    Op => instr,
    Reg2Loc => Reg2Loc,
	 ALUsrc => ALUsrc,
	MemtoReg => MemtoReg,
	 RegWrite => RegWrite,
	 MemRead => MemRead,
	 MemWrite => MemWrite,
	 Branch => Branch,
    AluOp => aluop,
    nonzBr => nonzBr
   );

aludec_0: entity work.aludec
	port map (
		funct => instr,
		aluop => aluop,
		alucontrol => alucontrol
	);
end architecture;
