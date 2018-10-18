library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity execute is
generic (N : integer:=64);
PORT (aluSrc: in std_logic;
		aluControl:in std_logic_vector(3 downto 0);
		PC_E, SignImm_E: in std_logic_vector(N-1 downto 0);
		readData1_E, readData2_E: in std_logic_vector(N-1 downto 0);
-- Output Signals
		PCBranch_E, aluResult_E: out std_logic_vector(N-1 downto 0);
		writeData_E : out std_logic_vector(N-1 downto 0);
		zero_E : out std_logic
		);
end execute;

architecture synth of execute is
signal SrcB_add: std_logic_vector(N-1 downto 0);
signal SrcB_alu: std_logic_vector(N-1 downto 0);

component mux64 is
PORT (d0, d1: in std_logic_vector(N-1 downto 0);
s : in std_LOGIC;
y : OUT std_logic_vector(N-1 downto 0));
end component;

component sll2 is
port (Din: in std_logic_vector(N-1 downto 0);
      Dout: out std_logic_vector(N-1 downto 0));
end component;


component alu is
PORT (ALUcontrol: in std_logic_vector (3 downto 0);
		a,b: in std_logic_vector(N-1 downto 0);
		result: out std_logic_vector(N-1 downto 0);
		zero: out STD_LOGIC
	);
end component;

component adder is
PORT (
A : in std_logic_vector(N-1 downto 0);
b : in std_logic_vector(N-1 downto 0);
y : OUT std_logic_vector(N-1 downto 0));
end component;

begin
   dut_ALU: ALU port map (ALUControl => aluControl, a => readData1_E, b => SrcB_alu, result => aluResult_E, zero => zero_E);
   writeData_E <= readData2_E;
	dut_MUX64: MUX64 port map (d1 => SignImm_E, d0 => readData2_E, s => aluSrc, y => SrcB_alu);
	dut_SLL2: SLL2 port map (Din => SignImm_E ,Dout => SrcB_add);
	dut_ADDER: ADDER port map (A => PC_E, b => SrcB_add , y => PCBranch_E);
end synth;
