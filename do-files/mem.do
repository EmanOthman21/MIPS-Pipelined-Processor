vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/IRIFIDOut \
sim:/cpu/PCIFIDOut \
sim:/cpu/flagOutBuffOut \
sim:/cpu/exec_stage_lbl/RdestNumID \
sim:/cpu/decode_stage_lbl/register_file_lbl/R1 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R2 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R3 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R4 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R5 \
sim:/cpu/fetch_stage_lbl/stall_pc_mux_out \
sim:/cpu/spOutMEMWBIn \
sim:/cpu/spOutMEMWBOut \
sim:/cpu/memory_stage_lbl/addressMuxOut \
sim:/cpu/memory_stage_lbl/Rdest \
sim:/cpu/memory_stage_lbl/memOut 

force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100

mem load -i D:/CMP3/2nd/Arch/mem.mem -format binary /cpu/fetch_stage_lbl/mainMemory/rom
mem load -i D:/CMP3/2nd/Arch/mem.mem -format binary /cpu/memory_stage_lbl/dataMemory/ram
property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b1 0
run 150


force -freeze sim:/cpu/reset 1'b0 0
run 150
force -freeze sim:/cpu/inPort 16#19 0
run 100
force -freeze sim:/cpu/inPort 16#ffff 0
run 100
force -freeze sim:/cpu/inPort 16#f320 0
run 150 
force -freeze sim:/cpu/inPort 16#10 0
run 1750