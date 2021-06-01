
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoding_stage IS
    GENERIC (
        controlSignalsSize : INTEGER := 32

    );
    PORT (
        pc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RdstNewValue : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RdstWriteBackNum : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        inputPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        RESET : IN STD_LOGIC;
        loadFlagEXMEM : IN STD_LOGIC;
        loadFlagMEMWB : IN STD_LOGIC;
        RdestNumEXMEM : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RdestNumMEMWB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        rdstWBSeclectorMEMWB : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        rdstWBSeclectorEXMEM : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        pcOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        rdstOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        rsrcOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        offsetOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        inputportOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        rdstNumOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        rsrcNumOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        controlSignalsOut : OUT STD_LOGIC_VECTOR(controlSignalsSize - 1 DOWNTO 0)
    );
END decoding_stage;

ARCHITECTURE decoding_stage_arch OF decoding_stage IS
    SIGNAL controlSignals : STD_LOGIC_VECTOR(controlSignalsSize - 1 DOWNTO 0);
BEGIN
    control_unit_lbl : ENTITY work.control_unit PORT MAP(IR, flags, RESET, controlSignals(0), controlSignals(1), controlSignals(2), controlSignals(3), controlSignals(5 DOWNTO 4), controlSignals(6), controlSignals(8 DOWNTO 7), controlSignals(9), controlSignals(10), controlSignals(11), controlSignals(15 DOWNTO 12), controlSignals(16), controlSignals(17), controlSignals(18), controlSignals(19), controlSignals(20));

    register_file_lbl : ENTITY work.register_file PORT MAP (IR, RdstNewValue, RdstWriteBackNum, controlSignals(5 DOWNTO 4), offsetOut, rdstOut, rsrcOut, rdstNumOut, rsrcNumOut);

    load_use_detection_lbl : ENTITY work.laod_use_detection PORT MAP(IR, loadFlagEXMEM, loadFlagMEMWB, RdestNumEXMEM, RdestNumMEMWB, controlSignals(21));

    data_hazard_unit_lbl : ENTITY work.DataHazardUnit PORT MAP (IR(29), IR(19 DOWNTO 16), RdestNumMEMWB, RdestNumEXMEM, rdstWBSeclectorMEMWB, rdstWBSeclectorEXMEM, controlSignals(23 DOWNTO 22), controlSignals(25 DOWNTO 24));

    controlSignalsOut <= controlSignals;
END decoding_stage_arch; -- decoding_stage_arch