library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- So we can resize from 32 to 64bit vector.

ENTITY signext IS
  PORT (a: IN STD_LOGIC_VECTOR(31 downto 0);
      y: OUT STD_LOGIC_VECTOR(63 downto 0));
END;

ARCHITECTURE synth OF signext IS
BEGIN
  y <= std_logic_vector(resize(signed(a(23 downto 5)), y'length)) WHEN
          (a(31 downto 24) = "10110100") ELSE -- CBZ
       std_logic_vector(resize(signed(a(20 downto 12)), y'length)) WHEN
          (a(31 downto 21) = "11111000010") ELSE -- LDUR
       std_logic_vector(resize(signed(a(20 downto 12)), y'length)) WHEN
          (a(31 downto 21) = "11111000000") ELSE -- STUR
       std_logic_vector(resize(signed(a(21 downto 10)), y'length)); -- I type
END;
