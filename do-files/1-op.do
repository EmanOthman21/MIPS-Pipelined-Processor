vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/outPort \
sim:/cpu/IRIFIDOut \
sim:/cpu/PCIFIDOut \
sim:/cpu/aluOutEXBuffOut \
sim:/cpu/flagOutBuffOut \
sim:/cpu/flagOutBuffIn\
sim:/cpu/decode_stage_lbl/register_file_lbl/R1 \
sim:/cpu/decode_stage_lbl/register_file_lbl/R2

force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100


mem load -i D:/CMP3/2nd/Arch/1-op.mem -format binary /cpu/fetch_stage_lbl/mainMemory/rom
mem load -i D:/CMP3/2nd/Arch/1-op.mem -format binary /cpu/memory_stage_lbl/dataMemory/ram
property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b1 0
run 200

force -freeze sim:/cpu/inPort 32'd5 0
force -freeze sim:/cpu/reset 1'b0 0
run 700
force -freeze sim:/cpu/inPort 16#10 0
run 1800