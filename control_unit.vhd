
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
        loadFlag : OUT STD_LOGIC
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
    --- -------------------------
    FUNCTION to_string (a : STD_LOGIC_VECTOR) RETURN STRING IS
        VARIABLE b : STRING (1 TO a'length) := (OTHERS => NUL);
        VARIABLE stri : INTEGER := 1;
    BEGIN
        FOR i IN a'RANGE LOOP
            b(stri) := STD_LOGIC'image(a((i)))(2);
            stri := stri + 1;
        END LOOP;
        RETURN b;
    END FUNCTION;
    ---------------
BEGIN
    PROCESS (IR)
        VARIABLE opCode : INTEGER := to_integer(unsigned(IR(31 DOWNTO 24)));

    BEGIN
        immFlag <= IR(29);
        opCode := to_integer(unsigned(IR(31 DOWNTO 24)));
        REPORT "IR opCode is " & INTEGER'image(opCode);
        REPORT "IR " & to_string(IR);

        -- generate contol signals
        IF RESET = '1' THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "00";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0000";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = NOP THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "00";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0000";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = SETC THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "00";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0000";
            clrCFlag <= '0';
            setCFlag <= '1';
            loadFlag <= '0';
        ELSIF opCode = CLRC THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "00";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0000";
            clrCFlag <= '1';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = CLR THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0001";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = NOTControl THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0010";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = INC THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0011";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = NEG THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0100";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = DEC THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0101";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = OUTControl THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "00";
            memAddressSelector <= '0';
            outputPort <= '1';
            inputPort <= '0';
            aluSelect <= "0000";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = INControl THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "00";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '1';
            aluSelect <= "0000";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = RLC THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0110";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = RRC THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0111";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = MOV THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1000";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = ADD THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1001";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = SUB THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1010";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = ANDControl THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0111";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = ORControl THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1100";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = IADD THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "10001";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = SHL THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1101";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = SHR THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '1';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1110";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = LDM THEN
            memRead <= '0';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "01";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1111";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = PUSH THEN
            memRead <= '0';
            memWrite <= '1';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "10";
            spWrite <= '1';
            rdstWBSeclector <= "00";
            memAddressSelector <= '1';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0000";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = POP THEN
            memRead <= '1';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "01";
            spWrite <= '1';
            rdstWBSeclector <= "10";
            memAddressSelector <= '1';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "0000";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        ELSIF opCode = LDD THEN
            memRead <= '1';
            memWrite <= '0';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "10";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1001";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '1';
        ELSIF opCode = STD THEN
            memRead <= '0';
            memWrite <= '1';
            pcSelector <= '0';
            flagWrite <= '0';
            spOperationSelector <= "00";
            spWrite <= '0';
            rdstWBSeclector <= "10";
            memAddressSelector <= '0';
            outputPort <= '0';
            inputPort <= '0';
            aluSelect <= "1001";
            clrCFlag <= '0';
            setCFlag <= '0';
            loadFlag <= '0';
        END IF;

    END PROCESS;
END controle_unit_default; -- controle_unit_default