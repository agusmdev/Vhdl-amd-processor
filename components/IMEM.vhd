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
  --signal ROM : memory_t:= (x"91003c0a", x"d503201f", x"aa14018b", x"8a14018c", x"8b0a0000",
  --                         x"cb01014a", x"F80003EB", x"F80083EC", x"b5ffff8a",
  --                         x"F80103E0", others => x"00000000");
  signal ROM : memory_t := (x"91003c01", x"f8010001", x"f8410002", others => x"00000000");

begin
		q <= ROM(63-to_integer(unsigned(addr)));
 end rtl;
