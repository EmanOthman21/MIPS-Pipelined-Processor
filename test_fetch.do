vsim -gui work.fetch
add wave -position insertpoint  \
sim:/fetch/pc
add wave -position insertpoint  \
sim:/fetch/pcDin
add wave -position insertpoint  \
sim:/fetch/pcDout
add wave -position insertpoint  \
sim:/fetch/firstTime
add wave -position insertpoint  \
sim:/fetch/stall_pc_mux_out
add wave -position insertpoint  \
sim:/fetch/pc_mux_out
add wave -position insertpoint  \
sim:/fetch/pcMuxOut
add wave -position insertpoint  \
sim:/fetch/m0
add wave -position insertpoint  \
sim:/fetch/irTemp
add wave -position insertpoint  \
sim:/fetch/reset \
sim:/fetch/loadUse \
sim:/fetch/pcOut \
sim:/fetch/IR \
sim:/fetch/clk
force -freeze sim:/fetch/clk 1 0, 0 {50 ps} -r 100
mem load -filltype value -filldata 16'd1 -fillradix unsigned /fetch/mainMemory/rom(0)
mem load -filltype value -filldata 16'd2 -fillradix unsigned /fetch/mainMemory/rom(1)
mem load -filltype value -filldata 16'd3 -fillradix unsigned /fetch/mainMemory/rom(2)
mem load -filltype value -filldata 16'd4 -fillradix unsigned /fetch/mainMemory/rom(3)
mem load -filltype value -filldata 16'd5 -fillradix unsigned /fetch/mainMemory/rom(4)
mem load -filltype value -filldata 16'd6 -fillradix unsigned /fetch/mainMemory/rom(5)
property wave -radix unsigned *


force -freeze sim:/fetch/reset 1'b1 0
force -freeze sim:/fetch/loadUse 1'b0 0
run 500
