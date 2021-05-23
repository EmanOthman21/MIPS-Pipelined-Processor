add wave -position end  sim:/write_back/SP_Old
add wave -position end  sim:/write_back/Control_Signals
add wave -position end  sim:/write_back/SP_New_Value

# Increment
force -freeze sim:/write_back/Control_Signals 2#0000000010000 0
force -freeze sim:/write_back/SP_Old 10#32 0
run

# Decrement
force -freeze sim:/write_back/Control_Signals 2#0000000001000 0
force -freeze sim:/write_back/Control_Signals 2#0000000001000 0
run

# No change
force -freeze sim:/write_back/Control_Signals 2#0000000000000 0
run

# Changing other parts of the control signal
force -freeze sim:/write_back/Control_Signals 2#1010101000101 0
run

# Forwarded
add wave -position end  sim:/write_back/Control_Signals_Forwarded
add wave -position end  sim:/write_back/RdestNum
add wave -position end  sim:/write_back/RdestNum_Forwarded
force -freeze sim:/write_back/RdestNum 10#14 0
run
