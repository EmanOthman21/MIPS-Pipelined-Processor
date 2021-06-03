vsim -gui work.memory
add wave -position insertpoint  \
sim:/memory/memRead \
sim:/memory/memWrite \
sim:/memory/memAddressSelector \
sim:/memory/ALUout \
sim:/memory/SP \
sim:/memory/Rdest \
sim:/memory/addressMuxOut \
sim:/memory/memOut \
sim:/memory/clk
force -freeze sim:/memory/clk 1 0, 0 {50 ps} -r 100

mem load -filltype value -filldata 16'd1 -fillradix unsigned /memory/dataMemory/ram(0)
mem load -filltype value -filldata 16'd2 -fillradix unsigned /memory/dataMemory/ram(1)
mem load -filltype value -filldata 16'd3 -fillradix unsigned /memory/dataMemory/ram(2)
mem load -filltype value -filldata 16'd4 -fillradix unsigned /memory/dataMemory/ram(3)
mem load -filltype value -filldata 16'd5 -fillradix unsigned /memory/dataMemory/ram(4)
mem load -filltype value -filldata 16'd6 -fillradix unsigned /memory/dataMemory/ram(5)
property wave -radix unsigned *


force -freeze sim:/memory/memRead 1'b1 0
force -freeze sim:/memory/memAddressSelector 1'b0 0
force -freeze sim:/memory/ALUout 32'hAFAF0000 0
run 500
