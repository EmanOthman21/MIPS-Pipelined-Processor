vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/outPort \
sim:/cpu/IRIFIDOut \
sim:/cpu/PCIFIDOut \
sim:/cpu/flagOutBuffOut \
sim:/cpu/inputportOutIDEXOut \
sim:/cpu/exec_stage_lbl/aluOut \
sim:/cpu/exec_stage_lbl/memOut \
sim:/cpu/exec_stage_lbl/Rdest \
sim:/cpu/exec_stage_lbl/control \
sim:/cpu/exec_stage_lbl/inSel2 \
sim:/cpu/exec_stage_lbl/aluComp/A \
sim:/cpu/exec_stage_lbl/aluComp/B \
sim:/cpu/exec_stage_lbl/RdestNumID \
sim:/cpu/RdestOutEXBuffIn \
sim:/cpu/aluOutEXBuffIn \
sim:/cpu/RdestNumBuffIn \
sim:/cpu/controlOutBuffIn \
sim:/cpu/controlSignalsOutIDEXOut \
sim:/cpu/controlSignalsOutIDEXIn \
sim:/cpu/controlSignalsOutMEMWBOut \
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
sim:/cpu/rdstNumOutMEMWBOut \
sim:/cpu/aluOutMEMWBOut \
sim:/cpu/memOutMEMWBOut \
sim:/cpu/inputportOutIDEXOut \
sim:/cpu/decode_stage_lbl/register_file_lbl/RdstNewValue \
sim:/cpu/decode_stage_lbl/register_file_lbl/RdstWriteBacknum \
sim:/cpu/decode_stage_lbl/RdstWriteBackNum \
sim:/cpu/decode_stage_lbl/control_unit_lbl/opCode \
sim:/cpu/spOutMEMWBIn \
sim:/cpu/spOutMEMWBOut \
sim:/cpu/memory_stage_lbl/addressMuxOut \
sim:/cpu/memory_stage_lbl/Rdest \
sim:/cpu/memory_stage_lbl/controlSignalsIn \
sim:/cpu/memory_stage_lbl/memOut \
sim:/cpu/RdstNewValue 

force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100

mem load -i D:/CMP3/2nd/Arch/memory.mem -format binary /cpu/fetch_stage_lbl/mainMemory/rom
mem load -i D:/CMP3/2nd/Arch/memory.mem -format binary /cpu/memory_stage_lbl/dataMemory/ram
property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b1 0
run 150


force -freeze sim:/cpu/reset 1'b0 0
run 150
force -freeze sim:/cpu/inPort 16#19 0
run 100
force -freeze sim:/cpu/inPort 16#ffff 0
run 50
force -freeze sim:/cpu/inPort 16#ffff 0
run 50


force -freeze sim:/cpu/inPort 16#f320 0
run 50 
force -freeze sim:/cpu/inPort 16#f320 0
run 100 
force -freeze sim:/cpu/inPort 16#10 0
run 1750