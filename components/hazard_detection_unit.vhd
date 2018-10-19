library IEEE;
	use IEEE.STD_LOGIC_1164.all;
		entity hazard_detection_unit is
      generic (N: integer := 32);
			port(ID_EX_MemRead: in std_logic;
				 ID_EX_RegisterRt,
				 IF_ID_RegisterRs,
         IF_ID_RegisterRt: in std_logic_vector(4 downto 0);
     -- PC_write: out std_logic_vector(n*2-1 downto 0);
			enable: out std_logic);
		end;
		architecture synth of hazard_detection_unit is
			begin
				process(ID_EX_MemRead, ID_EX_RegisterRt, IF_ID_RegisterRs, IF_ID_RegisterRt)
				begin
					if ((ID_EX_MemRead = '1') and ((ID_EX_RegisterRt = IF_ID_RegisterRs) or (ID_EX_RegisterRt = IF_ID_RegisterRt))) then
            enable <= '0';
             report "hay hazardoli bro xD";
          else 
             report "AAAAAAAAAAAAAAAAAAAAAAAA";
            enable <= '1';
          end if;
				end process;
		end synth;