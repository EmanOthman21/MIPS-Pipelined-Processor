vsim -gui work.instructions_memory
add wave -position insertpoint  \
sim:/instructions_memory/PC \
sim:/instructions_memory/instruction \
sim:/instructions_memory/clk
force -freeze sim:/instructions_memory/clk 1 0, 0 {25 ps} -r 50
mem load -i D:/CMP22/3B/Arch/project/Pipelined_Processor/test_instructions_memory.mem -format binary /instructions_memory/rom
property wave -radix hex *

force -freeze sim:/instructions_memory/PC 32'h00000000 0
run

force -freeze sim:/instructions_memory/PC 32'h00000002 0
run