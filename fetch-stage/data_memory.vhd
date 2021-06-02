LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY data_memory IS
	GENERIC (
		dataLineWidth : INTEGER := 32;
		addressLineWidth : INTEGER := 16
	);
	PORT (
		readWrite, clk : IN STD_LOGIC; -- 0 for read
		address : IN STD_LOGIC_VECTOR(addressLineWidth - 1 DOWNTO 0);
		data : IN STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0);
		memOut : OUT STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0)
	);
END data_memory;

ARCHITECTURE arch OF data_memory IS
	TYPE ram_type IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(addressLineWidth - 1 DOWNTO 0);
	SIGNAL ram : ram_type;
BEGIN
	main : PROCESS (clk)
	BEGIN
		IF rising_edge(clk) THEN
			IF (readWrite = '1') THEN
				ram(to_integer(unsigned(address))) <= data(addressLineWidth - 1 DOWNTO 0);
				ram(to_integer(unsigned(address)) + 1) <= data(dataLineWidth - 1 DOWNTO addressLineWidth);
			END IF;
		END IF;
	END PROCESS; -- main

	memOut(addressLineWidth - 1 DOWNTO 0) <= ram(to_integer(unsigned(address)));
	memOut(dataLineWidth - 1 DOWNTO addressLineWidth) <= ram(to_integer(unsigned(address)) + 1);
END arch;