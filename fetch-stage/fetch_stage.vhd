LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetch IS
	PORT (
		reset, loadUse : IN STD_LOGIC;
		pcIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		pcOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		IR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END fetch;

ARCHITECTURE fetch_stage OF fetch IS
	SIGNAL stall_pc_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pc_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pc_reset_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pcMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

	SIGNAL m0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL irTemp : STD_LOGIC_VECTOR(31 DOWNTO 0);

	SIGNAL pcAdder : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL reset_falling : STD_LOGIC;
BEGIN
	reset_falling <= '1' when reset'EVENT AND reset='0'
	else '0';

	pc_mux : ENTITY work.mux_2_1 PORT MAP (reset, pcIn, (others => '0'), pc_mux_out);

	pc_memory_reset : ENTITY work.mux_2_1 PORT MAP (reset_falling,pc_mux_out,irTemp,pc_reset_mux_out);

	stall_pc_mux : ENTITY work.mux_2_1 PORT MAP (loadUse, pc_reset_mux_out, stall_pc_mux_out, stall_pc_mux_out);

	mainMemory : ENTITY work.instructions_memory GENERIC MAP (65000, 32, 16) PORT MAP (reset, stall_pc_mux_out, m0, irTemp);

	pcAdder <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(stall_pc_mux_out)) + 2, 32)) WHEN irTemp(29) = '1' AND RESET = '0'
		ELSE
		STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(stall_pc_mux_out)) + 1, 32)) WHEN RESET = '0';

	IR <= irTemp;

	pcOut <= pcAdder;

END ARCHITECTURE;