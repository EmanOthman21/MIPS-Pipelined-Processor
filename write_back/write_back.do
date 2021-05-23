add wave -position end  sim:/write_back/ALU_Out
add wave -position end  sim:/write_back/Mem_Out
add wave -position end  sim:/write_back/WB_Sel
add wave -position end  sim:/write_back/Rdest_New_Value
force -freeze sim:/write_back/ALU_Out 10#120 0
force -freeze sim:/write_back/Mem_Out 10#34 0
force -freeze sim:/write_back/WB_Sel 2#00 0
run
force -freeze sim:/write_back/WB_Sel 2#01 0
run
force -freeze sim:/write_back/WB_Sel 2#10 0
run
force -freeze sim:/write_back/WB_Sel 2#11 0
run