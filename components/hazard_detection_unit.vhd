library IEEE;
	use IEEE.STD_LOGIC_1164.all;
		entity hazard_detection_unit is
      generic (N: integer := 32);
			port(ID_EX_MemRead, ID_EX_RegWrite, EX_MEM_MemRead, EX_MEM_RegWrite, IF_ID_branch, clk: in std_logic;
         IF_ID_RegisterRm,
         IF_ID_RegisterRn,
         IF_ID_RegisterRd,
         ID_EX_RegisterRd,
         EX_MEM_RegisterRd: in std_logic_vector(4 downto 0);
			enable: out std_logic);
		end;
		architecture synth of hazard_detection_unit is
			begin
				process(ID_EX_MemRead, ID_EX_RegWrite, EX_MEM_MemRead, EX_MEM_RegWrite, IF_ID_branch,
         IF_ID_RegisterRm,
         IF_ID_RegisterRn,
         IF_ID_RegisterRd,
         ID_EX_RegisterRd,
         EX_MEM_RegisterRd, clk)
        begin
          if (clk'event and clk = '0') then
          	if (
                ((ID_EX_MemRead = '1' or ID_EX_RegWrite = '1') and (IF_ID_RegisterRn = ID_EX_RegisterRd or IF_ID_RegisterRm = ID_EX_RegisterRd)) or
                ((EX_MEM_MemRead = '1' or EX_MEM_RegWrite = '1') and (IF_ID_RegisterRn = EX_MEM_RegisterRd or IF_ID_RegisterRm = EX_MEM_RegisterRd)) or
                (IF_ID_branch = '1' and (IF_ID_RegisterRd = ID_EX_RegisterRd or IF_ID_RegisterRd = EX_MEM_RegisterRd))
                ) 
              then
                enable <= '0';
            else 
                enable <= '1';
            end if;
          end if;
				end process;
		end synth;