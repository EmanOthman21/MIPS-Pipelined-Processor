library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity write_back is
  generic (
    sp_op_high: integer := 4;
    sp_op_low: integer := 3;
    data_size: integer := 32
  );

  port (
    RdestNum: in std_logic_vector(3 downto 0);
    ALU_Out: in std_logic_vector(data_size-1 downto 0);
    Mem_Out: in std_logic_vector(data_size-1 downto 0);
    Control_Signals: in std_logic_vector(13 downto 0);
    WB_Sel: in std_logic_vector(1 downto 0);
    SP_Old: in std_logic_vector(data_size-1 downto 0);
    
    Rdest_New_Value: out std_logic_vector(data_size-1 downto 0);
    SP_New_Value: out std_logic_vector(data_size-1 downto 0);
    RdestNum_Forwarded: out std_logic_vector(3 downto 0);
    Control_Signals_Forwarded: out std_logic_vector(13 downto 0)
  ) ;
end write_back;

architecture write_back_arch of write_back is
	signal sp_sel: std_logic_vector(1 downto 0);
begin
	sp_sel <= Control_Signals(sp_op_high downto sp_op_low);
  	
	-- Rdest
    Rdest_New_Value <=  ALU_Out WHEN WB_Sel = "01" ELSE
                        Mem_Out WHEN WB_Sel = "10" ELSE
                        (others => '0');

	-- SP Update
	SP_New_Value <= std_logic_vector(unsigned(SP_Old) + 2) WHEN sp_sel = "01" ELSE
					std_logic_vector(unsigned(SP_Old) - 2) WHEN sp_sel = "10" ELSE
					SP_Old;
	
	-- Forwarded
	RdestNum_Forwarded <= RdestNum;
	Control_Signals_Forwarded <= Control_Signals;
end write_back_arch ; -- write_back_arch`