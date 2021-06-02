Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY flag IS
  PORT ( cin, changeEnable,setCarry,clrCarry: IN std_logic;
  inFlag: IN std_logic_vector (2 downto 0);
  F: IN std_logic_vector(15 downto 0);
	outFlag: OUT std_logic_vector (2 downto 0));
END flag;

ARCHITECTURE flag_arch OF flag IS
  BEGIN
  outFlag(2) <= cin when changeEnable = '1'
  else '0' when clrCarry = '1'
  else '1' when setCarry = '1'
  else inFlag(2);

  outFlag(1) <= F(15) when changeEnable = '1'
  else inFlag(1);

  outFlag(0) <= '1' when F = "0000000000000000" and changeEnable = '1'
  else '0' when changeEnable = '1'
  else inFlag(0);
END flag_arch;