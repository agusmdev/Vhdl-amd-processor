library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fetch is
			generic (N : integer:=64);
PORT (reset, clk,PCSrc_F: IN STD_LOGIC;
		PCbranch_F: in std_logic_vector (N-1 downto 0);
		imem_addr_F: out std_logic_vector (N-1 downto 0);
		IFID_enable: in std_logic
		);
end fetch;

architecture synth of fetch is
signal PCplus4: std_logic_vector(N-1 downto 0);
signal PC: std_logic_vector(N-1 downto 0);
signal PCnext : std_logic_vector(N-1 downto 0);

component mux64 is
PORT (d0, d1: in std_logic_vector(N-1 downto 0);
s : in std_LOGIC;
y : OUT std_logic_vector(N-1 downto 0));
end component;


component flopre is
PORT (clk,reset, enable : IN STD_LOGIC;
d : in std_logic_vector(N-1 downto 0);
q : OUT std_logic_vector(N-1 downto 0));
end component;

component adder is
PORT (
A : in std_logic_vector(N-1 downto 0);
B : in std_logic_vector(N-1 downto 0);
y : OUT std_logic_vector(N-1 downto 0));
end component;
begin
   dut_FLOPR: FLOPRE port map (reset => reset, clk => clk, enable => IFID_enable, d => PCnext, q => PC);
	imem_addr_F <= PC;
   dut_MUX64: MUX64 port map (d1 => PCbranch_F, d0 => PCplus4, s => PCSrc_F, y => PCnext);
	dut_ADDER: ADDER port map (A => PC, B => (x"0000000000000004"), y => PCplus4);
end synth;
