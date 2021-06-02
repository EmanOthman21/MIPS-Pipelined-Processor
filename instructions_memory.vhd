LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY instructions_memory IS
	GENERIC (
		dataLineWidth : INTEGER := 32;
		addressLineWidth : INTEGER := 16
	);
	PORT (
		clk, reset : IN STD_LOGIC;
		PC : IN STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0);
		m0 : OUT STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0);
		instruction : OUT STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0)
	);
END instructions_memory;

ARCHITECTURE arch OF instructions_memory IS
	TYPE ram_type IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(addressLineWidth - 1 DOWNTO 0);
	SIGNAL rom : ram_type;
BEGIN
	main : PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF reset = '1' THEN
				m0(addressLineWidth - 1 DOWNTO 0) <= rom(0);
				m0(dataLineWidth - 1 DOWNTO addressLineWidth) <= rom(1);
			ELSE
				instruction(addressLineWidth - 1 DOWNTO 0) <= rom(to_integer(unsigned(PC)));
				instruction(dataLineWidth - 1 DOWNTO addressLineWidth) <= rom(to_integer(unsigned(PC)) + 1);
			END IF;
		END IF;
	END PROCESS; -- main

END arch;