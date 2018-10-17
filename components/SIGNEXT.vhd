library IEEE;
	use IEEE.STD_LOGIC_1164.all;
		entity signext is
			port( a: in std_logic_vector(32-1 downto 0);
					y: out std_logic_vector(64-1 downto 0)
			);
		end;
architecture synth of signext is
begin 
	process(a)
	begin
		if (a(31 downto 23) = "111110000" and  a(21) = '0') then
			y <= (others => a(20));
			y(7 downto 0) <= a(19 downto 12);				
		elsif ( a(31 downto 24) = "10110100") then
			y <= (others => a(23));
			y(17 downto 0) <= a(22 downto 5);
		else
			y <= (others => '0');
		end if;
	end process;
end synth;