onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor_arm_tb/clk
add wave -noupdate /processor_arm_tb/finish
add wave -noupdate /processor_arm_tb/dump
add wave -noupdate /processor_arm_tb/reset
add wave -noupdate /processor_arm_tb/DM_addr
add wave -noupdate /processor_arm_tb/DM_writeData
add wave -noupdate /processor_arm_tb/DM_writeEnable
add wave -noupdate /processor_arm_tb/led
add wave -noupdate /processor_arm_tb/clk
add wave -noupdate /processor_arm_tb/dut/reset
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/IM_readData
add wave -noupdate /processor_arm_tb/dut/datapath_0/fetch_0/dut_FLOPR/enable
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/fetch_0/dut_FLOPR/d
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/fetch_0/dut_FLOPR/q
add wave -noupdate /processor_arm_tb/dut/datapath_0/fetch_0/IFID_enable
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/fetch_0/PC
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/fetch_0/PCnext
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/PCBranch
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/writeData_D
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/decode_0/regfile_0/rd1
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/decode_0/regfile_0/rd2
add wave -noupdate /processor_arm_tb/dut/datapath_0/decode_0/regfile_0/we3
add wave -noupdate /processor_arm_tb/dut/datapath_0/decode_0/regfile_0/ra1
add wave -noupdate /processor_arm_tb/dut/datapath_0/decode_0/regfile_0/ra2
add wave -noupdate /processor_arm_tb/dut/datapath_0/decode_0/regfile_0/wa3
add wave -noupdate /processor_arm_tb/dut/datapath_0/decode_0/regfile_0/wd3
add wave -noupdate /processor_arm_tb/dut/datapath_0/regWrite
add wave -noupdate /processor_arm_tb/dut/datapath_0/AluControl
add wave -noupdate /processor_arm_tb/dut/datapath_0/AluSrc
add wave -noupdate /processor_arm_tb/dut/datapath_0/memtoReg
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/readData1
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/readData2
add wave -noupdate /processor_arm_tb/dut/datapath_0/IDEX_regWrite
add wave -noupdate /processor_arm_tb/dut/datapath_0/IDEX_AluControl
add wave -noupdate /processor_arm_tb/dut/datapath_0/IDEX_AluSrc
add wave -noupdate /processor_arm_tb/dut/datapath_0/IDEX_memtoReg
add wave -noupdate /processor_arm_tb/dut/datapath_0/IDEX_instr
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/IDEX_readData2_E
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/IDEX_readData1_E
add wave -noupdate /processor_arm_tb/dut/datapath_0/EXMEM_regWrite
add wave -noupdate /processor_arm_tb/dut/datapath_0/EXMEM_memtoReg
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/EXMEM_aluResult_E
add wave -noupdate /processor_arm_tb/dut/datapath_0/EXMEM_instr
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/MEMWB_aluresult_E
add wave -noupdate /processor_arm_tb/dut/datapath_0/MEMWB_instr
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/MEMWB_readData
add wave -noupdate /processor_arm_tb/dut/datapath_0/MEMWB_memtoReg
add wave -noupdate /processor_arm_tb/dut/datapath_0/MEMWB_regWrite
add wave -noupdate /processor_arm_tb/dut/datapath_0/control_signals
add wave -noupdate /processor_arm_tb/dut/datapath_0/new_control
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/IFID_IM_readData_s
add wave -noupdate -radix hexadecimal /processor_arm_tb/dut/datapath_0/IM_readData
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/ID_EX_MemRead
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/ID_EX_RegWrite
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/EX_MEM_MemRead
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/EX_MEM_RegWrite
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/IF_ID_branch
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/IF_ID_RegisterRm
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/IF_ID_RegisterRn
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/IF_ID_RegisterRd
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/ID_EX_RegisterRd
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/EX_MEM_RegisterRd
add wave -noupdate /processor_arm_tb/dut/datapath_0/hazard_unit/enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 391
configure wave -valuecolwidth 162
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {126 ns}
