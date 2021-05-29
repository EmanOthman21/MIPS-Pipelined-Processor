
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
    control_unit_lbl : ENTITY work.control_unit PORT MAP(IR, flags, RESET, controlSignals(controlSignalsSize - 1), controlSignals(controlSignalsSize - 2), controlSignals(controlSignalsSize - 3), controlSignals(controlSignalsSize - 4), controlSignals(controlSignalsSize - 5 DOWNTO controlSignalsSize - 6), controlSignals(controlSignalsSize - 7), controlSignals(controlSignalsSize - 8 DOWNTO controlSignalsSize - 9), controlSignals(controlSignalsSize - 10), controlSignals(controlSignalsSize - 11), controlSignals(controlSignalsSize - 12), controlSignals(controlSignalsSize - 13 DOWNTO controlSignalsSize - 16), controlSignals(controlSignalsSize - 17), controlSignals(controlSignalsSize - 18), controlSignals(controlSignalsSize - 19), controlSignals(controlSignalsSize - 20));

    register_file_lbl : ENTITY work.register_file PORT MAP (IR, RdstNewValue, RdstWriteBackNum, controlSignals(controlSignalsSize - 5 DOWNTO controlSignalsSize - 6), offsetOut, rdstOut, rsrcOut, rdstNumOut, rsrcNumOut);

    load_use_detection_lbl : ENTITY work.laod_use_detection PORT MAP(IR, loadFlagEXMEM, loadFlagMEMWB, RdestNumEXMEM, RdestNumMEMWB, controlSignals(controlSignalsSize - 21));

    data_hazard_unit_lbl : ENTITY work.DataHazardUnit PORT MAP (IR(29), IR(19 DOWNTO 16), RdestNumMEMWB, RdestNumEXMEM, rdstWBSeclectorMEMWB, rdstWBSeclectorEXMEM, controlSignals(controlSignalsSize - 22 DOWNTO controlSignalsSize - 23), controlSignals(controlSignalsSize - 24 DOWNTO controlSignalsSize - 25));

    controlSignalsOut <= controlSignals;
END decoding_stage_arch; -- decoding_stage_arch