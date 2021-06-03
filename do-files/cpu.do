vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/outPort \
sim:/cpu/PCIFIDOut \
sim:/cpu/IRIFIDOut \
sim:/cpu/IRIFIDIn \
sim:/cpu/fetch_stage_lbl/stall_pc_mux_out \
sim:/cpu/RdestOutEXBuffOut \
sim:/cpu/aluOutEXBuffOut \
sim:/cpu/RdestNumBuffOut \
sim:/cpu/flagOutBuffOut \
sim:/cpu/controlOutBuffOut \
sim:/cpu/controlSignalsOutIDEXIn \
sim:/cpu/rdstNumOutIDEXIn \
sim:/cpu/rdstNumOutIDEXOut

force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100


mem load -filltype value -filldata 16'b0 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(0)
mem load -filltype value -filldata 16'b0100000000100001 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(1)


mem load -filltype value -filldata 16'b0001010100110000 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(2)
mem load -filltype value -filldata 16'b0001001001000000 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(3)
property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b1 0
run 100
force -freeze sim:/cpu/reset 1'b0 0
run 1000