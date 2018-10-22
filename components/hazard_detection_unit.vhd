library IEEE;
	use IEEE.STD_LOGIC_1164.all;
		entity hazard_detection_unit is
      generic (N: integer := 32);
			port(ID_EX_MemRead, ID_EX_RegWrite, EX_MEM_MemRead, EX_MEM_RegWrite, IF_ID_branch: in std_logic;
         IF_ID_RegisterRm,
         IF_ID_RegisterRn,
         IF_ID_RegisterRd,
         ID_EX_RegisterRd,
         EX_MEM_RegisterRd: in std_logic_vector(4 downto 0);
			enable: out std_logic);
		end;
		architecture synth of hazard_detection_unit is
			begin
          	enable <= '0' when (ID_EX_RegisterRd /= "11111" and EX_MEM_RegisterRd /= "11111"
                and (((ID_EX_MemRead = '1' or ID_EX_RegWrite = '1')
                     and (IF_ID_RegisterRn = ID_EX_RegisterRd or IF_ID_RegisterRm = ID_EX_RegisterRd))
                or ((EX_MEM_MemRead = '1' or EX_MEM_RegWrite = '1')
                     and (IF_ID_RegisterRn = EX_MEM_RegisterRd or IF_ID_RegisterRm = EX_MEM_RegisterRd))
                or (IF_ID_branch = '1'
                     and (IF_ID_RegisterRd = ID_EX_RegisterRd or IF_ID_RegisterRd = EX_MEM_RegisterRd))))
            else '1';
		end synth;
