LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetch IS
	PORT (
		clk, reset, loadUse : IN STD_LOGIC;
		pcOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		IR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END fetch;

ARCHITECTURE fetch_stage OF fetch IS
	SIGNAL pc : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL stall_pc_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pc_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pcMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL m0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL irTemp : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	pc_mux : ENTITY work.mux_2_1 PORT MAP (reset, pc, m0, pc_mux_out);

	stall_pc_mux : ENTITY work.mux_2_1 PORT MAP (loadUse, pc_mux_out, pc, stall_pc_mux_out);

	mainMemory : ENTITY work.instructions_memory GENERIC MAP (32, 16) PORT MAP (clk, reset, pc, m0, irTemp);

	mainLogic : PROCESS (clk, reset, loadUse)
		VARIABLE firstTime : INTEGER := 0;
	BEGIN
		IF falling_edge(clk) THEN
			IF irTemp(29) = '1' THEN
				pc <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(pc)) + 2, 32));
			ELSE
				pc <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(pc)) + 1, 32));
			END IF;
		END IF;

		IF rising_edge(clk) THEN
			IF (firstTime = 0) THEN
				pc <= (OTHERS => '0');
				firstTime := 1;
				REPORT "This is a message";
			ELSE
				pc <= stall_pc_mux_out;
			END IF;
		END IF;
	END PROCESS;

	IR <= irTemp;

	pcOut <= pc;

END ARCHITECTURE;