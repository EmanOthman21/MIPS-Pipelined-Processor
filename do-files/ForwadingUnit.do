add wave -position insertpoint  \
sim:/forwarding/wbMem \
sim:/forwarding/wbEX \
sim:/forwarding/srcNumID \
sim:/forwarding/selector \
sim:/forwarding/destNumMem \
sim:/forwarding/destNumEX
force -freeze sim:/forwarding/srcNumID 10#4 0
force -freeze sim:/forwarding/destNumEX 10#3 0
force -freeze sim:/forwarding/destNumMem 10#2 0
force -freeze sim:/forwarding/wbMem 1 0
force -freeze sim:/forwarding/wbEX 1 0
run
force -freeze sim:/forwarding/destNumEX 10#4 0
run
force -freeze sim:/forwarding/destNumMem 10#4 0
run
force -freeze sim:/forwarding/destNumEX 10#3 0
run
force -freeze sim:/forwarding/wbMem 0 0
run
force -freeze sim:/forwarding/wbEX 0 0
run
force -freeze sim:/forwarding/destNumEX 10#4 0
force -freeze sim:/forwarding/wbMem 1 0
run