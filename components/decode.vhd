library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity decode is
   generic (N: integer := 64);
    port(regWrite_D, reg2loc_D, clk: in std_logic;
        writeData3_D: in std_logic_vector(N-1 downto 0);
          instr_D: in std_logic_vector(31 downto 0);
      wa3_D: in std_logic_vector(4 downto 0);
      reg_rn: out std_logic_vector(4 downto 0);
        signImm_D, readData1_D, readData2_D: out std_logic_vector(N-1 downto 0));
end entity;

architecture behav of decode is

signal readAddr2 : std_logic_vector(4 downto 0);

begin
    mux2_0: entity work.mux2 generic map (N => 5) port map(
                                        d0 =>instr_D(20 downto 16),
                                        d1 => instr_D(4 downto 0),
                                        s => reg2loc_D,
                                        y => readAddr2);

    regfile_0: entity work.regfile port map (
                    clk => clk,
                    we3 => regWrite_D,
                    ra1 => instr_D(9 downto 5),
                    ra2 => readAddr2,
                    wa3 => wa3_D,
                    wd3 => writeData3_D,
                    rd1 => readData1_D,
                    rd2 => readData2_D);

    signext_0: entity work.signext port map(
                    a => instr_D,
                    y => signImm_D);
    reg_rn <= readAddr2;
end architecture;
