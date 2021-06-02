vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/outPort \
sim:/cpu/PCFetch \
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
sim:/cpu/EXOut 
force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100
mem load -filltype value -filldata 16'b0000000100000000 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(0)
mem load -filltype value -filldata 16'd2 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(1)

property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b0 0
run 1000