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
sim:/cpu/PCDecode \
sim:/cpu/IR \
sim:/cpu/controlSignals \
sim:/cpu/flags \
sim:/cpu/RdstNewValue \
sim:/cpu/RdstWriteBackNum \
sim:/cpu/loadFlagEXMEM \
sim:/cpu/loadFlagMEMWB \
sim:/cpu/RdestNumEXMEM \
sim:/cpu/RdestNumMEMWB \
sim:/cpu/rdstOut \
sim:/cpu/rsrcOut \
sim:/cpu/offsetOut \
sim:/cpu/inputportOut \
sim:/cpu/rdstNumOut \
sim:/cpu/decode_stage_lbl/register_file_lbl/R0 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R1 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R2 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R3 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R4 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R5 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R6 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R7 \
sim:/cpu/EXIn \
sim:/cpu/EXOut \
sim:/cpu/RdestOutEXBuffOut \
sim:/cpu/aluOutEXBuffOut \
sim:/cpu/RdestNumBuffOut \
sim:/cpu/flagOutBuffOut \
sim:/cpu/controlOutBuffOut 

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