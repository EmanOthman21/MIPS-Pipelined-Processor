LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY register_simple IS
	PORT (
		d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END register_simple;

ARCHITECTURE a_Reg OF register_simple IS
BEGIN
	q <= d;
END a_Reg;