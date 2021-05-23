library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity write_back is
  port (
    RdestNum: in std_logic_vector(3 downto 0);
    ALU_Out: in std_logic_vector(31 downto 0);
    Mem_Out: in std_logic_vector(31 downto 0);
    Control_Signals: in std_logic_vector(13 downto 0);
    WB_Sel: in std_logic_vector(1 downto 0);
    Rdest_New_Value: out std_logic_vector(31 downto 0)
  ) ;
end write_back;

architecture write_back_arch of write_back is
begin
    Rdest_New_Value <=  ALU_Out WHEN WB_Sel = "01" ELSE
                        Mem_Out WHEN WB_Sel = "10" ELSE
                        (others => '0');
end write_back_arch ; -- write_back_arch