add wave -position insertpoint  \
sim:/flag/setCarry \
sim:/flag/outFlag \
sim:/flag/inFlag \
sim:/flag/F \
sim:/flag/clrCarry \
sim:/flag/cin \
sim:/flag/changeEnable
force -freeze sim:/flag/changeEnable 0 0
force -freeze sim:/flag/cin 1 0
force -freeze sim:/flag/inFlag 101 0
force -freeze sim:/flag/clrCarry 0 0
force -freeze sim:/flag/setCarry 0 0
force -freeze sim:/flag/F 10#10 0
run
force -freeze sim:/flag/clrCarry 1 0
force -freeze sim:/flag/changeEnable 1 0
run
force -freeze sim:/flag/inFlag 001 0
force -freeze sim:/flag/cin 0 0
force -freeze sim:/flag/clrCarry 0 0
force -freeze sim:/flag/setCarry 1 0
run
force -freeze sim:/flag/setCarry 0 0
force -freeze sim:/flag/F 10000000000000000000000000001010 0
run
force -freeze sim:/flag/F 10#0 0
force -freeze sim:/flag/inFlag 000 0
force -freeze sim:/flag/clrCarry 0 0
run