LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY CPU IS
    PORT (
        clk, RESET : IN STD_LOGIC;
        inPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        outPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END CPU;

ARCHITECTURE CPU_arch OF CPU IS
    SIGNAL PCFetch : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL PCDecode : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL IR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL controlSignals : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL RdstNewValue : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RdstWriteBackNum : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL loadFlagEXMEM : STD_LOGIC;
    SIGNAL loadFlagMEMWB : STD_LOGIC;
    SIGNAL RdestNumEXMEM : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL RdestNumMEMWB : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rdstOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rsrcOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL offsetOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL inputportOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rdstNumOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rsrcNumOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    fetch_stage_lbl :
    ENTITY work.fetch PORT MAP(clk, reset, controlSignals(21), PCFetch, IR);

    decode_stage_lbl : ENTITY work.decoding_stage GENERIC MAP (32) PORT MAP(clk, PCFetch, IR, RdstNewValue, RdstWriteBackNum, inPort, flags, RESET, loadFlagEXMEM, loadFlagMEMWB, RdestNumEXMEM, RdestNumMEMWB, PCDecode, rdstOut, rsrcOut, offsetOut, inputportOut, rdstNumOut, rsrcNumOut, controlSignals);
END CPU_arch; -- CPU_arch