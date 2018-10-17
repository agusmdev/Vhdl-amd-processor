-- Quartus II VHDL Template
-- Single-Port ROM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem is

	generic (N : integer := 32);

	port(	addr	: in std_logic_vector (5 downto 0);
			q		: out std_logic_vector(N-1 downto 0)
		);

end entity;

architecture rtl of imem is
	-- Build a 2-D array type for the ROM
	subtype word_t is std_logic_vector(N-1 downto 0);
	type memory_t is array(63 downto 0) of word_t;

	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the
	-- default value.
	--signal ROM : memory_t:=	(x"f8000000", x"f8008001", x"f8010002", x"f8018003", x"f8020004", x"f8028005",x"f8030006",
	--								 x"f8400007", x"f8408008", x"f8410009",x"f841800a", x"f842000b", x"f842800c", x"f843000d",
	--								 x"cb0e01ce", x"b400004e", x"cb01000f", x"8b01000f",		x"f803800f", others => x"00000000");
  signal ROM : memory_t:= (x"8b030040", x"8b030042", x"d503201f", x"d503201f", x"d503201f", x"8b030043", others => x"00000000");

begin
		q <= ROM(63-to_integer(unsigned(addr)));
 end rtl;
