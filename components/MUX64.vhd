  library IEEE;
     use IEEE.STD_LOGIC_1164.all;

     ENTITY MUX64 IS
        PORT(d0 : IN std_logic_vector(63 DOWNTO 0); 
             d1 : IN std_logic_vector(63 DOWNTO 0); 
             s : IN std_logic; 
             y : OUT std_logic_vector(63 DOWNTO 0));
     END MUX64;

     ARCHITECTURE synth OF MUX64 IS
     BEGIN
        WITH s SELECT y <=
		d0 WHEN '0',
		d1 WHEN '1',
	  	unaffected WHEN OTHERS;

     END synth;	