LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memory IS
	PORT (
		memRead, memWrite, memAddressSelector : IN STD_LOGIC;
		Rdest, ALUout, SP : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		memOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END memory;

ARCHITECTURE memory_stage OF memory IS
	SIGNAL addressMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

	addressMux : ENTITY work.mux_2_1 PORT MAP (memAddressSelector, ALUout, SP, addressMuxOut);

	dataMemory : ENTITY work.data_memory GENERIC MAP (16, 32, 16) PORT MAP (memRead, memWrite, addressMuxOut(31 DOWNTO 16), Rdest, memOut);

END ARCHITECTURE;