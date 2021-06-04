vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/outPort \
sim:/cpu/PCIFIDOut \
sim:/cpu/IRIFIDOut \
sim:/cpu/IRIFIDIn \
sim:/cpu/PCIFIDOut \
sim:/cpu/IRIFIDOut \
sim:/cpu/RdestOutEXBuffOut \
sim:/cpu/aluOutEXBuffOut \
sim:/cpu/RdestNumBuffOut \
sim:/cpu/flagOutBuffOut \
sim:/cpu/controlOutBuffOut \
sim:/cpu/controlSignalsOutIDEXOut \
sim:/cpu/controlSignalsOutIDEXIn \
sim:/cpu/rdstNumOutIDEXIn \
sim:/cpu/rdstNumOutIDEXOut \
sim:/cpu/decode_stage_lbl/register_file_lbl/R0 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R1 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R2 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R3 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R4 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R5 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R6 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R7 \
sim:/cpu/fetch_stage_lbl/stall_pc_mux_out \
sim:/cpu/fetch_stage_lbl/pcIn \
sim:/cpu/RdstNewValue \
sim:/cpu/rdstNumOutMEMWBOut \
sim:/cpu/decode_stage_lbl/register_file_lbl/RdstNewValue \
sim:/cpu/decode_stage_lbl/register_file_lbl/RdstWriteBacknum \
sim:/cpu/decode_stage_lbl/RdstWriteBackNum \
sim:/cpu/decode_stage_lbl/control_unit_lbl/opCode

force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100


mem load -i /home/bahaa/Downloads/1-op.mem -format binary /cpu/fetch_stage_lbl/mainMemory/rom
mem load -i /home/bahaa/Downloads/1-op.mem -format binary /cpu/memory_stage_lbl/dataMemory/ram
property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b1 0
run 150

force -freeze sim:/cpu/inPort 32'd5 0
force -freeze sim:/cpu/reset 1'b0 0
run 1000