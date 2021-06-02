vsim -gui work.data_memory
add wave -position insertpoint  \
sim:/data_memory/readWrite \
sim:/data_memory/address \
sim:/data_memory/data \
sim:/data_memory/memOut \
sim:/data_memory/clk
force -freeze sim:/data_memory/clk 1 0, 0 {25 ps} -r 50
mem load -i D:/CMP22/3B/Arch/project/Pipelined_Processor/test_data_memory.mem -format binary /data_memory/ram
property wave -radix hex *

force -freeze sim:/data_memory/readWrite 1'b1 0
force -freeze sim:/data_memory/data 32'h0000FFA1 0
force -freeze sim:/data_memory/address 16'h0000 0
run

force -freeze sim:/data_memory/readWrite 1'b0 0
force -freeze sim:/data_memory/address 16'h0000 0
run