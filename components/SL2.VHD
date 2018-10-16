library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


entity sl2 is
	generic (width: integer := 64);
   port (a : in std_logic_vector (width-1 downto 0);
         y : out std_logic_vector (width-1 downto 0)); 
end sl2;
 
architecture Behavior of sl2 is
begin
	process(a)
	begin

		y(0) <= '0';
		y(1) <= '0';

		for i in 0 to width-3 loop 
			  y(i+2) <= a(i);     
		end loop;

	end process;
end Behavior;