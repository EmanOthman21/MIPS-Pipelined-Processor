vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/outPort \
sim:/cpu/PCIFIDIn \
sim:/cpu/IRIFIDIn \
sim:/cpu/RdestOutEXBuffOut \
sim:/cpu/aluOutEXBuffOut \
sim:/cpu/RdestNumBuffOut \
sim:/cpu/flagOutBuffOut \
sim:/cpu/controlOutBuffOut \
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
sim:/cpu/decode_stage_lbl/register_file_lbl/R7 

force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100


mem load -i /home/bahaa/Downloads/1-op.mem -format binary /cpu/fetch_stage_lbl/mainMemory/rom
mem load -i /home/bahaa/Downloads/1-op.mem -format binary /cpu/memory_stage_lbl/dataMemory/ram
property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b1 0
run 100

force -freeze sim:/cpu/inPort 32'd5 0
force -freeze sim:/cpu/reset 1'b0 0
run 1000