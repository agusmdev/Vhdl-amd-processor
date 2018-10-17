library ieee;
use ieee.std_logic_1164.all;

entity memory is
    port(
	 Branch, zero: in std_logic;
    PCSrc: out std_logic
	 );
end entity;

architecture behav of memory is

begin

PCSrc <= Branch and zero;

end architecture;