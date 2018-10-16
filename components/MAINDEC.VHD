library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity maindec is
	port(Op: in std_logic_vector(10 downto 0);
	Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: out STD_LOGIC;
	AluOp : out std_logic_vector( 1 downto 0 )
	);
end;
architecture synth of maindec is
begin
process(op)
begin
	if( op(10)= '1' and op(7 downto 4) = "0101" and op(2 downto 0) = "000") then
		--r-format
		Reg2Loc 	<='0';
		ALUSrc 	<='0';
		MemtoReg	<='0';
		RegWrite	<='1';
		MemRead	<='0';
		MemWrite	<='0';
		Branch	<='0';
		Aluop		<="10";
	elsif(op = "11111000010")then
	--ldur
	   Reg2Loc 	<='0';
		ALUSrc 	<='1';
		MemtoReg	<='1';
		RegWrite	<='1';
		MemRead	<='1';
		MemWrite	<='0';
		Branch	<='0';
		Aluop		<="00";
	elsif(op = "11111000000" )then
	--stur
		Reg2Loc 	<='1';
		ALUSrc 	<='1';
	   MemtoReg	<='0';
		RegWrite	<='0';
		MemRead	<='0';
		MemWrite	<='1';
		Branch	<='0';
		Aluop		<="00";
	else
	--cbz
		Reg2Loc 	<='1';
		ALUSrc 	<='0';
	   MemtoReg	<='0';
		RegWrite	<='0';
		MemRead	<='0';
		MemWrite	<='0';
		Branch	<='1';
		Aluop		<="01";
	end if;
	end process;
end synth;