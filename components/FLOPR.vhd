library IEEE;
	use IEEE.STD_LOGIC_1164.all;
		entity flopr is
			generic (N : integer:=64);
			port(clk,reset: in STD_LOGIC;
			d: in std_logic_vector(N-1 downto 0);
			q: out std_logic_vector(N-1 downto 0));
		end;
		architecture synth of flopr is
			begin
				process(clk,reset)
				begin
						if (reset = '1') then
							q <= (others => '0');
						elsif rising_edge(clk) then
							q <= d;
						end if;
				end process;
		end synth;