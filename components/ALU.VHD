library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_lOGIC_SIGNED.all;
entity alu is
	port( ALUcontrol: in std_logic_vector (3 downto 0);
			a,b: in std_logic_vector(63 downto 0);
			result: out std_logic_vector(63 downto 0);
			zero: out STD_LOGIC
	);
end;

architecture synth of alu is
begin 
	process(a,b,ALUcontrol)
	variable res: std_logic_vector(63 downto 0);
	variable z: std_logic_vector(63 downto 0);
	begin
	
	case ALUcontrol is
		when "0000"=> res := a and b;
		when "0001"=> res := a or b;
		when "0010"=> res := a + b;
		when "0110"=> res := a - b;
		when "0111"=> res := b;
		when "1100"=> res := a nor b;
		when others => res := (others => '0');
	end case;
	
	z := (others => '0');
	if (res = z) then 
		zero <= '1';
	else
		zero <= '0';
	end if;
	result <= res;

	end process;
end synth;