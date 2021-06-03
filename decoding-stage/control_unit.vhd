
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--USE ieee.STD_LOGIC_ARITH.ALL;
--USE ieee.STD_LOGIC_UNSIGNED.ALL;

ENTITY control_unit IS
    PORT (
        IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        flags : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        RESET : IN STD_LOGIC;
        loadFlagEXMEM : IN STD_LOGIC;
        loadFlagMEMWB : IN STD_LOGIC;
        RdestNumEXMEM : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RdestNumMEMWB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        memRead : OUT STD_LOGIC;
        memWrite : OUT STD_LOGIC;
        pcSelector : OUT STD_LOGIC;
        flagWrite : OUT STD_LOGIC;
        spOperationSelector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        spWrite : OUT STD_LOGIC;
        rdstWBSeclector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        memAddressSelector : OUT STD_LOGIC;
        outputPort : OUT STD_LOGIC;
        inputPort : OUT STD_LOGIC;
        aluSelect : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        clrCFlag : OUT STD_LOGIC;
        setCFlag : OUT STD_LOGIC;
        immFlag : OUT STD_LOGIC;
        loadFlag : OUT STD_LOGIC;
        rdstWB : OUT STD_LOGIC;
        loadUse : OUT STD_LOGIC
    );
END control_unit;

ARCHITECTURE controle_unit_default OF control_unit IS
    SIGNAL operation : STD_LOGIC_VECTOR(5 DOWNTO 0);
    -- define contants 
    CONSTANT NOP : INTEGER := 16#0#;
    CONSTANT SETC : INTEGER := 16#1#;
    CONSTANT CLRC : INTEGER := 16#2#;
    CONSTANT CLR : INTEGER := 16#10#;
    CONSTANT NOTControl : INTEGER := 16#11#;
    CONSTANT INC : INTEGER := 16#12#;
    CONSTANT NEG : INTEGER := 16#13#;
    CONSTANT DEC : INTEGER := 16#14#;
    CONSTANT OUTControl : INTEGER := 16#15#;
    CONSTANT INControl : INTEGER := 16#16#;
    CONSTANT RLC : INTEGER := 16#17#;
    CONSTANT RRC : INTEGER := 16#18#;
    CONSTANT MOV : INTEGER := 16#40#;
    CONSTANT ADD : INTEGER := 16#41#;
    CONSTANT SUB : INTEGER := 16#42#;
    CONSTANT ANDControl : INTEGER := 16#43#;
    CONSTANT ORControl : INTEGER := 16#44#;
    CONSTANT IADD : INTEGER := 16#65#;
    CONSTANT SHL : INTEGER := 16#66#;
    CONSTANT SHR : INTEGER := 16#67#;
    CONSTANT LDM : INTEGER := 16#68#;
    CONSTANT PUSH : INTEGER := 16#80#;
    CONSTANT POP : INTEGER := 16#81#;
    CONSTANT LDD : INTEGER := 16#b0#;
    CONSTANT STD : INTEGER := 16#b1#;
    CONSTANT RET : INTEGER := 16#c0#;
    CONSTANT RTI : INTEGER := 16#c1#;
    CONSTANT JZ : INTEGER := 16#d0#;
    CONSTANT JN : INTEGER := 16#d1#;
    CONSTANT JC : INTEGER := 16#d2#;
    CONSTANT JMP : INTEGER := 16#d3#;
    CONSTANT CALL : INTEGER := 16#d4#;
    SIGNAL opCode : INTEGER;

BEGIN
    load_use_detection_lbl : ENTITY work.laod_use_detection PORT MAP (IR, loadFlagEXMEM, loadFlagMEMWB, RdestNumEXMEM, RdestNumMEMWB, loadUse);

    immFlag <= IR(29);
    opCode <= to_integer(unsigned(IR(31 DOWNTO 24)));
    memRead <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '1' WHEN(opCode = POP) ELSE
        '1' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    memWrite <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '1' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '1' WHEN(opCode = STD);
    pcSelector <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    flagWrite <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '1' WHEN(opCode = SETC) ELSE
        '1' WHEN(opCode = CLRC) ELSE
        '1' WHEN(opCode = CLR) ELSE
        '1' WHEN(opCode = NOTControl) ELSE
        '1' WHEN(opCode = INC) ELSE
        '1' WHEN(opCode = NEG) ELSE
        '1' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '1' WHEN(opCode = RLC) ELSE
        '1' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '1' WHEN(opCode = ADD) ELSE
        '1' WHEN(opCode = SUB) ELSE
        '1' WHEN(opCode = ANDControl) ELSE
        '1' WHEN(opCode = ORControl) ELSE
        '1' WHEN(opCode = IADD) ELSE
        '1' WHEN(opCode = SHL) ELSE
        '1' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    spOperationSelector <= "00" WHEN(RESET = '1') ELSE
        "00" WHEN(opCode = NOP) ELSE
        "00" WHEN(opCode = SETC) ELSE
        "00" WHEN(opCode = CLRC) ELSE
        "00" WHEN(opCode = CLR) ELSE
        "00" WHEN(opCode = NOTControl) ELSE
        "00" WHEN(opCode = INC) ELSE
        "00" WHEN(opCode = NEG) ELSE
        "00" WHEN(opCode = DEC) ELSE
        "00" WHEN(opCode = OUTControl) ELSE
        "00" WHEN(opCode = INControl) ELSE
        "00" WHEN(opCode = RLC) ELSE
        "00" WHEN(opCode = RRC) ELSE
        "00" WHEN(opCode = MOV) ELSE
        "00" WHEN(opCode = ADD) ELSE
        "00" WHEN(opCode = SUB) ELSE
        "00" WHEN(opCode = ANDControl) ELSE
        "00" WHEN(opCode = ORControl) ELSE
        "00" WHEN(opCode = IADD) ELSE
        "00" WHEN(opCode = SHL) ELSE
        "00" WHEN(opCode = SHR) ELSE
        "00" WHEN(opCode = LDM) ELSE
        "10" WHEN(opCode = PUSH) ELSE
        "01" WHEN(opCode = POP) ELSE
        "00" WHEN(opCode = LDD) ELSE
        "00" WHEN(opCode = STD);
    spWrite <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '1' WHEN(opCode = PUSH) ELSE
        '1' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    rdstWBSeclector <= "00" WHEN(RESET = '1') ELSE
        "00" WHEN(opCode = NOP) ELSE
        "00" WHEN(opCode = SETC) ELSE
        "00" WHEN(opCode = CLRC) ELSE
        "01" WHEN(opCode = CLR) ELSE
        "01" WHEN(opCode = NOTControl) ELSE
        "01" WHEN(opCode = INC) ELSE
        "01" WHEN(opCode = NEG) ELSE
        "01" WHEN(opCode = DEC) ELSE
        "00" WHEN(opCode = OUTControl) ELSE
        "00" WHEN(opCode = INControl) ELSE
        "01" WHEN(opCode = RLC) ELSE
        "01" WHEN(opCode = RRC) ELSE
        "01" WHEN(opCode = MOV) ELSE
        "01" WHEN(opCode = ADD) ELSE
        "01" WHEN(opCode = SUB) ELSE
        "01" WHEN(opCode = ANDControl) ELSE
        "01" WHEN(opCode = ORControl) ELSE
        "01" WHEN(opCode = IADD) ELSE
        "01" WHEN(opCode = SHL) ELSE
        "01" WHEN(opCode = SHR) ELSE
        "01" WHEN(opCode = LDM) ELSE
        "00" WHEN(opCode = PUSH) ELSE
        "10" WHEN(opCode = POP) ELSE
        "10" WHEN(opCode = LDD) ELSE
        "10" WHEN(opCode = STD);
    memAddressSelector <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '1' WHEN(opCode = PUSH) ELSE
        '1' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    outputPort <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '1' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    inputPort <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '1' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    aluSelect <= "0000" WHEN(RESET = '1') ELSE
        "0000" WHEN(opCode = NOP) ELSE
        "0000" WHEN(opCode = SETC) ELSE
        "0000" WHEN(opCode = CLRC) ELSE
        "0001" WHEN(opCode = CLR) ELSE
        "0010" WHEN(opCode = NOTControl) ELSE
        "0011" WHEN(opCode = INC) ELSE
        "0100" WHEN(opCode = NEG) ELSE
        "0101" WHEN(opCode = DEC) ELSE
        "0000" WHEN(opCode = OUTControl) ELSE
        "0000" WHEN(opCode = INControl) ELSE
        "0110" WHEN(opCode = RLC) ELSE
        "0111" WHEN(opCode = RRC) ELSE
        "1000" WHEN(opCode = MOV) ELSE
        "1001" WHEN(opCode = ADD) ELSE
        "1010" WHEN(opCode = SUB) ELSE
        "0111" WHEN(opCode = ANDControl) ELSE
        "1100" WHEN(opCode = ORControl) ELSE
        "1001" WHEN(opCode = IADD) ELSE
        "1101" WHEN(opCode = SHL) ELSE
        "1110" WHEN(opCode = SHR) ELSE
        "1111" WHEN(opCode = LDM) ELSE
        "0000" WHEN(opCode = PUSH) ELSE
        "0000" WHEN(opCode = POP) ELSE
        "1001" WHEN(opCode = LDD) ELSE
        "1001" WHEN(opCode = STD);
    clrCFlag <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '1' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    setCFlag <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '1' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '0' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    loadFlag <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '0' WHEN(opCode = NOTControl) ELSE
        '0' WHEN(opCode = INC) ELSE
        '0' WHEN(opCode = NEG) ELSE
        '0' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '0' WHEN(opCode = INControl) ELSE
        '0' WHEN(opCode = RLC) ELSE
        '0' WHEN(opCode = RRC) ELSE
        '0' WHEN(opCode = MOV) ELSE
        '0' WHEN(opCode = ADD) ELSE
        '0' WHEN(opCode = SUB) ELSE
        '0' WHEN(opCode = ANDControl) ELSE
        '0' WHEN(opCode = ORControl) ELSE
        '0' WHEN(opCode = IADD) ELSE
        '0' WHEN(opCode = SHL) ELSE
        '0' WHEN(opCode = SHR) ELSE
        '0' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '1' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
    rdstWB <= '0' WHEN(RESET = '1') ELSE
        '0' WHEN(opCode = NOP) ELSE
        '0' WHEN(opCode = SETC) ELSE
        '0' WHEN(opCode = CLRC) ELSE
        '0' WHEN(opCode = CLR) ELSE
        '1' WHEN(opCode = NOTControl) ELSE
        '1' WHEN(opCode = INC) ELSE
        '1' WHEN(opCode = NEG) ELSE
        '1' WHEN(opCode = DEC) ELSE
        '0' WHEN(opCode = OUTControl) ELSE
        '1' WHEN(opCode = INControl) ELSE
        '1' WHEN(opCode = RLC) ELSE
        '1' WHEN(opCode = RRC) ELSE
        '1' WHEN(opCode = MOV) ELSE
        '1' WHEN(opCode = ADD) ELSE
        '1' WHEN(opCode = SUB) ELSE
        '1' WHEN(opCode = ANDControl) ELSE
        '1' WHEN(opCode = ORControl) ELSE
        '1' WHEN(opCode = IADD) ELSE
        '1' WHEN(opCode = SHL) ELSE
        '1' WHEN(opCode = SHR) ELSE
        '1' WHEN(opCode = LDM) ELSE
        '0' WHEN(opCode = PUSH) ELSE
        '0' WHEN(opCode = POP) ELSE
        '1' WHEN(opCode = LDD) ELSE
        '0' WHEN(opCode = STD);
END controle_unit_default; -- controle_unit_default