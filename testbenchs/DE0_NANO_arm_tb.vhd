library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DE0_NANO_arm_tb is

end DE0_NANO_arm_tb;

architecture Behavior of DE0_NANO_arm_tb is
constant CLK_PERIOD : time := 20 ns;
signal KEY : std_logic_vector (1 downto 0);
signal CLOCK_50, finish : std_logic:= '0';
signal LED : std_logic_vector (7 downto 0);

begin
	dut: entity work.DE0_NANO_arm
	port map (
        KEY => KEY,
		  CLOCK_50 => CLOCK_50,
		  LED => LED
		);

	CLOCK_50 <= not CLOCK_50 after CLK_PERIOD/2 when finish /= '1' else '0'; -- Generate Clock signal
	test_proc: process
	begin
		KEY(0) <= '0';  -- reset
		wait for CLK_PERIOD;
		KEY(0) <= '1';
		wait for CLK_PERIOD*8;
		finish <= '1';
		wait;
	end process;

end;













