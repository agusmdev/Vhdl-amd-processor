library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- REMOVE AFTER
use ieee.numeric_std.all;

entity maindec is
	port(Op: in std_logic_vector(10 downto 0);
	nonzBr, Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch: out STD_LOGIC;
	AluOp : out std_logic_vector( 1 downto 0 )
	);
end;
architecture synth of maindec is
begin
process(op)
begin
	if( op(10)= '1' and op(7 downto 4) = "0101" and op(2 downto 0) = "000") then
		--r-format
    report("Executing R-format");
		Reg2Loc 	<='0';
		ALUSrc 	<='0';
		MemtoReg	<='0';
		RegWrite	<='1';
		MemRead	<='0';
		MemWrite	<='0';
		Branch	<='0';
    nonzBr <= '0';
		Aluop		<="10";
  elsif(op(10 downto 1) = "1001000100") then
    --addi
    report("Executing addi");
    Reg2Loc   <='0';
    ALUSrc  <='1';
    MemtoReg  <='0';
    RegWrite  <='1';
    MemRead <='0';
    MemWrite  <='0';
    Branch  <='0';
    nonzBr <= '0';
    Aluop   <="10";
	elsif(op = "11111000010")then
	--ldur
    report("Executing LDUR");
	 Reg2Loc 	<='0';
		ALUSrc 	<='1';
		MemtoReg	<='1';
		RegWrite	<='1';
		MemRead	<='1';
		MemWrite	<='0';
		Branch	<='0';
    nonzBr <= '0';
		Aluop		<="00";
	elsif(op = "11111000000" ) then
	--stur
    report("Executing STUR");
		Reg2Loc 	<='1';
		ALUSrc 	<='1';
	   MemtoReg	<='0';
		RegWrite	<='0';
		MemRead	<='0';
		MemWrite	<='1';
		Branch	<='0';
    nonzBr <= '0';
		Aluop		<="00";
  elsif (op = "00000000000" or op = "11010101000") then
  --Nop
  report("Executing NOP");
    Reg2Loc   <='0';
    ALUSrc  <='0';
     MemtoReg <='0';
    RegWrite  <='0';
    MemRead <='0';
    MemWrite  <='0';
    Branch  <='0';
    nonzBr <= '0';
    Aluop   <="00";
  elsif (op(10 downto 3) = "10110101") then
  --cbnz
  report("Executing CBNZ");
  Reg2Loc   <='1';
  ALUSrc  <='0';
  MemtoReg <='0';
  RegWrite  <='0';
  MemRead <='0';
  MemWrite  <='0';
  Branch  <='1';
  nonzBr <= '1';
  Aluop   <="01";
	else
	--cbz
    report("Executing CBZ");
		Reg2Loc 	<='1';
		ALUSrc 	<='0';
	   MemtoReg	<='0';
		RegWrite	<='0';
		MemRead	<='0';
		MemWrite	<='0';
		Branch	<='1';
    nonzBr <= '0';
		Aluop		<="01";
	end if;
	end process;
end synth;
