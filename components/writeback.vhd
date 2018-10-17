library ieee;
use ieee.std_logic_1164.all;

entity writeback is
    port(
	 aluResult, DM_readData : in std_logic_vector (63 downto 0);
	 memtoReg: in std_logic;
    writeData: out std_logic_vector (63 downto 0)
	 );
end entity;

architecture behav of writeback is

begin

	mux2_4: entity work.mux2 generic map (N => 64) port map(
												 d0 => aluResult,
												 d1 => DM_readData,
												 s => memtoReg,
												 y => writeData);

end architecture;