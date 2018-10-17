library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity regfile is
	port(clk,we3: in STD_LOGIC;
	ra1,ra2,wa3: in std_logic_vector(4 downto 0);
	wd3: in std_logic_vector(63 downto 0);
	rd1,rd2: out std_logic_vector(63 downto 0));
end;

architecture synth of regfile is
	subtype reg is std_logic_vector(63 downto 0);
	type reg_t is array(31 downto 0) of reg;

function init_reg
return reg_t is
variable tmp : reg_t := (others => (others => '0'));
	begin
		for i in 0 to 31 loop
			-- Initialize each address with the address itself
			tmp(i) := std_logic_vector(to_unsigned(i, 64));
			if (i = 31)then
				tmp(i):=(others => '0');
			end if;
		end loop;
		return tmp;
end init_reg;

signal reg_bank : reg_t := init_reg;

begin
	process(clk,ra1,ra2,we3,wa3,wd3,reg_bank)
	begin

	if (rising_edge(clk) and (we3 = '1') and (to_integer(unsigned(wa3)) < 31 )) then
    report "Writing " & integer'image(to_integer(unsigned(wd3))) & " In "
    & integer'image(to_integer(unsigned(wa3)));
		reg_bank(to_integer(unsigned(wa3))) <= wd3;
	end if;
	rd1 <= reg_bank(to_integer(unsigned(ra1)));
	rd2 <= reg_bank(to_integer(unsigned(ra2)));

	end process;
end synth;
