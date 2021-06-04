Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY flag IS
  PORT (reset, cin, changeEnable,setCarry,clrCarry: IN std_logic;
  inFlag: IN std_logic_vector (2 downto 0);
  F: IN std_logic_vector(31 downto 0);
	outFlag: OUT std_logic_vector (2 downto 0));
END flag;

ARCHITECTURE flag_arch OF flag IS
  BEGIN
  outFlag(2) <= '0' when ((clrCarry = '1' and changeEnable = '1') or reset='1')
  else '1' when setCarry = '1' and changeEnable = '1'
  else cin when changeEnable = '1'
  else inFlag(2);

  outFlag(1) <= '0' when reset='1'
  else F(31) when (changeEnable = '1' and (F(31) = '0' or F(31)='1'))
  else inFlag(1);

  outFlag(0) <= '0' when reset = '1'
  else '1' when F="00000000000000000000000000000000" and changeEnable = '1'
  else inFlag(0) when ((F(0) /= '0' and F(0) /= '1' ) or (F(1) /= '0' and F(1) /= '1' ) or (F(2) /= '0' and F(2) /= '1' ) or (F(3) /= '0' and F(3) /= '1' ) or (F(4) /= '0' and F(4) /= '1' ) or (F(5) /= '0' and F(5) /= '1' ) or (F(6) /= '0' and F(6) /= '1' ) or (F(7) /= '0' and F(7) /= '1' ) or (F(8) /= '0' and F(8) /= '1' ) or (F(9) /= '0' and F(9) /= '1' ) or (F(10) /= '0' and F(10) /= '1' ) or (F(11) /= '0' and F(11) /= '1' ) or (F(12) /= '0' and F(12) /= '1' ) or (F(13) /= '0' and F(13) /= '1' ) or (F(14) /= '0' and F(14) /= '1' ) or (F(15) /= '0' and F(15) /= '1' ) or (F(16) /= '0' and F(16) /= '1' ) or (F(17) /= '0' and F(17) /= '1' ) or (F(18) /= '0' and F(18) /= '1' ) or (F(19) /= '0' and F(19) /= '1' ) or (F(20) /= '0' and F(20) /= '1' ) or (F(21) /= '0' and F(21) /= '1' ) or (F(22) /= '0' and F(22) /= '1' ) or (F(23) /= '0' and F(23) /= '1' ) or (F(24) /= '0' and F(24) /= '1' ) or (F(25) /= '0' and F(25) /= '1' ) or (F(26) /= '0' and F(26) /= '1' ) or (F(27) /= '0' and F(27) /= '1' ) or (F(28) /= '0' and F(28) /= '1' ) or (F(29) /= '0' and F(29) /= '1' ) or (F(30) /= '0' and F(30) /= '1' ) or (F(31) /= '0' and F(31) /= '1' )) or changeEnable ='0'
  else '0';
END flag_arch;