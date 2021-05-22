vsim work.control_unit
add wave -position insertpoint  \
sim:/control_unit/IR \
sim:/control_unit/memRead \
sim:/control_unit/memWrite \
sim:/control_unit/pcSelector \
sim:/control_unit/flagWrite \
sim:/control_unit/spOperationSelector \
sim:/control_unit/spWrite \
sim:/control_unit/rdstWBSeclector \
sim:/control_unit/memAddressSelector \
sim:/control_unit/outputPort \
sim:/control_unit/inputPort \
sim:/control_unit/operation

force -freeze sim:/control_unit/IR 00000000111111110000000000000000 0 
run 50

force -freeze sim:/control_unit/IR 00000001111111110000000000000001 0 
run 50