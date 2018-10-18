library ieee;
use ieee.std_logic_1164.all;

entity DE0_NANO_arm is
    port (
        KEY : in std_logic_vector (1 downto 0);
		  CLOCK_50 : in std_logic;
		  LED : out std_logic_vector (7 downto 0)
    );
end DE0_NANO_arm;

architecture arch of DE0_NANO_arm is

signal dump,clk: std_logic;
signal led_enable : std_logic;
signal led_s: std_logic_vector (63 downto 0);
signal DM_addr_s, DM_writeData_s: std_logic_vector (63 downto 0);
signal DM_writeEnable_s : std_logic;
signal DM_readEnable_s : std_logic;
begin
arm_proc_0: entity work.processor_arm
	port map (
	 clk => clk,
	 reset => not(KEY(0)),
	 dump => DUMP,
		DM_addr => DM_addr_s,
		DM_writeData => DM_writeData_s,
		DM_writeEnable => DM_writeEnable_s,
    DM_readEnable => DM_readEnable_s
	 );

clkDiv_0: entity work.clkDiv
	port map (
	   clk => CLOCK_50,
      reset => not(KEY(0)),
      clkDiv => clk
		);

LED <= led_s (7 downto 0);

led_enable <= '1' when (DM_writeEnable_s = '1' and DM_addr_s = x"0000000000000000") else '0';

process (clk)
begin
	if (rising_edge(clk)) then
		if (led_enable = '1') then
			led_s <= DM_writeData_s;
		end if;
	end if;
end process;

end arch;
