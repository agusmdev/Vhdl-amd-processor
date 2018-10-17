transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/SLL2.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/SIGNEXT.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/REGFILE.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/MUX64.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/mux2.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/memory.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/MAINDEC.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/IMEM.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/FLOPR.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/FETCH.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/EXECUTE.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/dmem.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/aludec.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/ALU.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/adder.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/clkDiv.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/writeback.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/decode.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/controller.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/datapath.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/components/processor_arm.vhd}
vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/DE0_NANO_arm.vhd}

vcom -2008 -work work {/home/ariel-nt/Desktop/Facultad/Arquitectura del Computador/Laboratorio/DE0_NANO_ARM/testbenchs/processor_arm_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  processor_arm_tb

add wave *
view structure
view signals
run -all
