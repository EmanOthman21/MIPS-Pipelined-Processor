vsim -gui work.memory
add wave -position insertpoint  \
sim:/memory/memRead \
sim:/memory/memWrite \
sim:/memory/memAddressSelector \
sim:/memory/Rdest \
sim:/memory/ALUout \
sim:/memory/SP \
sim:/memory/memOut \

mem load -filltype value -filldata 16'd1 -fillradix unsigned /memory/dataMemory/ram(0)
mem load -filltype value -filldata 16'd2 -fillradix unsigned /memory/dataMemory/ram(1)
mem load -filltype value -filldata 16'd3 -fillradix unsigned /memory/dataMemory/ram(2)
mem load -filltype value -filldata 16'd4 -fillradix unsigned /memory/dataMemory/ram(3)
mem load -filltype value -filldata 16'd5 -fillradix unsigned /memory/dataMemory/ram(4)
mem load -filltype value -filldata 16'd6 -fillradix unsigned /memory/dataMemory/ram(5)
property wave -radix hex *

force -freeze sim:/memory/memRead 1'b0 0
force -freeze sim:/memory/memWrite 1'b1 0
force -freeze sim:/memory/memAddressSelector 1'b0 0
force -freeze sim:/memory/ALUout 32'h00000000 0
force -freeze sim:/memory/Rdest 32'h00050008 0
run 100

# force -freeze sim:/memory/memRead 1'b1 0
# force -freeze sim:/memory/memWrite 1'b0 0
# force -freeze sim:/memory/ALUout 32'h00000000 0
# run 100
