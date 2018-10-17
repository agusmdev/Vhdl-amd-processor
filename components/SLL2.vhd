library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sll2 is
    port ( 
        Din: in std_logic_vector(63 downto 0);
        Dout: out std_logic_vector(63 downto 0)
    );
end;

architecture behavioral of sll2 is
begin

    Dout <= std_logic_vector(unsigned(Din) sll 2);

end behavioral;