    library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;
    entity clkDiv is
    port(
      clk         : in  std_logic;
      reset         : in  std_logic;
      clkDiv   : out std_logic);
    end clkDiv;
    architecture rtl of clkDiv is
    signal clk_divider        : unsigned(20 downto 0);
    begin
    p_clk_divider: process(reset,clk)
    begin
      if(reset='1') then
        clk_divider   <= (others=>'0');
      elsif(rising_edge(clk)) then
        clk_divider   <= clk_divider + 1;
      end if;
    end process p_clk_divider;
    clkDiv   <= clk_divider(20);
    end rtl;