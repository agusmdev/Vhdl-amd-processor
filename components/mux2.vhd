library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

entity mux2 is
	generic (N: integer := 64);
	port(	d0,d1 : 	in STD_LOGIC_VECTOR(N-1 downto 0);
			s : 		in STD_LOGIC;
			y : 		out STD_LOGIC_VECTOR(N-1 downto 0));
end;

architecture synth of mux2 is
begin
	y <= d1 when s = '1' else d0;
end;
