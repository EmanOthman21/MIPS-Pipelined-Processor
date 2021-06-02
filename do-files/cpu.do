vsim work.cpu
add wave -position insertpoint  \
sim:/cpu/clk \
sim:/cpu/RESET \
sim:/cpu/inPort \
sim:/cpu/outPort \
sim:/cpu/PCFetch \
sim:/cpu/PCDecode \
sim:/cpu/IR \
sim:/cpu/controlSignals \
sim:/cpu/flags \
sim:/cpu/RdstNewValue \
sim:/cpu/RdstWriteBackNum \
sim:/cpu/loadFlagEXMEM \
sim:/cpu/loadFlagMEMWB \
sim:/cpu/RdestNumEXMEM \
sim:/cpu/RdestNumMEMWB \
sim:/cpu/rdstOut \
sim:/cpu/rsrcOut \
sim:/cpu/offsetOut \
sim:/cpu/inputportOut \
sim:/cpu/rdstNumOut
force -freeze sim:/cpu/clk 1 0, 0 {50 ps} -r 100
mem load -filltype value -filldata 16'd1 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(0)
mem load -filltype value -filldata 16'd2 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(1)
mem load -filltype value -filldata 16'd3 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(2)
mem load -filltype value -filldata 16'd4 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(3)
mem load -filltype value -filldata 16'd5 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(4)
mem load -filltype value -filldata 16'd6 -fillradix unsigned /cpu/fetch_stage_lbl/mainMemory/rom(5)
property wave -radix hexa *

force -freeze sim:/cpu/reset 1'b0 0
run 1000