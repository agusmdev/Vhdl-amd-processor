library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity aludec is
port (
    funct  : in std_logic_vector( 10 downto 0 );
    aluop  : in  std_logic_vector( 1 downto 0 );  
    alucontrol : out std_logic_vector( 3 downto 0 )
   );
end entity;

architecture behavior of aludec is
begin
process (aluop,funct) 
    begin
        if (aluop= "00") then	--LDUR or STUR
            alucontrol  <= "0010";
        elsif (aluop = "01") then	--CBZ
            alucontrol  <= "0111";
        elsif( (aluop = "10" or aluop = "11") and funct = "10001011000" ) then -- ADD
            alucontrol<= "0010";
        elsif( (aluop = "10" or aluop = "11") and funct = "11001011000" ) then  -- SUB
            alucontrol<= "0110";
        elsif( (aluop = "10" or aluop = "11") and funct = "10001010000" ) then -- AND
            alucontrol<= "0000";
        elsif( (aluop = "10" or aluop = "11") and funct = "10101010000" ) then  -- OR
            alucontrol<= "0001";
		  else
		      alucontrol <= "1111";
        end if;
end process;
end architecture;