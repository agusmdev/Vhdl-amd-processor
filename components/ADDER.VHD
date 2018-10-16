library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 



entity adder is
	generic( N: integer := 64);
   port( 	a, b : in std_logic_vector (N-1 downto 0);
				y : out std_logic_vector (N-1 downto 0)); 
end adder;
 
architecture Behavior of adder is
    begin
    y <= std_logic_vector(signed(a) + signed(b));
end Behavior;
