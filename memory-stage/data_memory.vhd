LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY data_memory IS
	GENERIC (
		memorySize : INTEGER := 16;
		dataLineWidth : INTEGER := 32;
		addressLineWidth : INTEGER := 16
	);
	PORT (
		memRead, memWrite : IN STD_LOGIC;
		address : IN STD_LOGIC_VECTOR(addressLineWidth - 1 DOWNTO 0);
		data : IN STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0);
		memOut : OUT STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0)
	);
END data_memory;

ARCHITECTURE arch OF data_memory IS
	TYPE ram_type IS ARRAY(0 TO memorySize - 1) OF STD_LOGIC_VECTOR(addressLineWidth - 1 DOWNTO 0);
	SIGNAL ram : ram_type;
BEGIN
	ram(to_integer(unsigned(address)) + 1) <= data(addressLineWidth - 1 DOWNTO 0) WHEN memWrite = '1';
	ram(to_integer(unsigned(address))) <= data(dataLineWidth - 1 DOWNTO addressLineWidth) WHEN memWrite = '1';

	memOut(addressLineWidth - 1 DOWNTO 0) <= ram(to_integer(unsigned(address)) + 1) WHEN memRead = '1';
	memOut(dataLineWidth - 1 DOWNTO addressLineWidth) <= ram(to_integer(unsigned(address))) WHEN memRead = '1';
END arch;