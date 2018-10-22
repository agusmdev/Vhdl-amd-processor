library IEEE;
	use IEEE.STD_LOGIC_1164.all;
		entity flopre is
			generic (N : integer:=64);
			port(clk,reset, enable: in STD_LOGIC;
			d: in std_logic_vector(N-1 downto 0);
			q: out std_logic_vector(N-1 downto 0));
		end;
		architecture synth of flopre is
			begin
				process(clk, reset, enable)
				begin
						if (reset = '1') then
							q <= (others => '0');
						elsif (falling_edge(clk) and enable = '1') then
							q <= d;
						end if;
				end process;
		end synth;
