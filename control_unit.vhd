
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- use ieee.numeric_std.all;
USE ieee.STD_LOGIC_ARITH.ALL;
USE ieee.STD_LOGIC_UNSIGNED.ALL;

ENTITY control_unit IS
    PORT (
        IR : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        memRead : OUT STD_LOGIC;
        memWrite : OUT STD_LOGIC;
        pcSelector : OUT STD_LOGIC;
        flagWrite : OUT STD_LOGIC;
        spOperationSelector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        spWrite : OUT STD_LOGIC;
        rdstWBSeclector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        memAddressSelector : OUT STD_LOGIC;
        outputPort : OUT STD_LOGIC;
        inputPort : OUT STD_LOGIC
    );
END control_unit;

ARCHITECTURE controle_unit_default OF control_unit IS
    SIGNAL operation : STD_LOGIC_VECTOR(5 DOWNTO 0);
    -- define contants 
    CONSTANT NOP : INTEGER = x"0";
    CONSTANT SETC : INTEGER = x"1";
    CONSTANT CLRC : INTEGER = x"2";
    CONSTANT CLR : INTEGER = x"10";
    CONSTANT _NOT : INTEGER = x"11";
    CONSTANT INC : INTEGER = x"12";
    CONSTANT NEG : INTEGER = x"13";
    CONSTANT DEC : INTEGER = x"14";
    CONSTANT _OUT : INTEGER = x"15";
    CONSTANT _IN : INTEGER = x"16";
    CONSTANT RLC : INTEGER = x"17";
    CONSTANT RRC : INTEGER = x"18";
    CONSTANT MOV : INTEGER = x"40";
    CONSTANT ADD : INTEGER = x"41";
    CONSTANT SUB : INTEGER = x"42";
    CONSTANT _AND : INTEGER = x"43";
    CONSTANT _OR : INTEGER = x"44";
    CONSTANT IADD : INTEGER = x"65";
    CONSTANT SHL : INTEGER = x"66";
    CONSTANT SHR : INTEGER = x"67";
    CONSTANT LDM : INTEGER = x"68";
    CONSTANT PUSH : INTEGER = x"80";
    CONSTANT POP : INTEGER = x"81";
    CONSTANT LDD : INTEGER = x"b0";
    CONSTANT STD : INTEGER = x"b1";
    CONSTANT RET : INTEGER = x"c0";
    CONSTANT RTI : INTEGER = x"c1";
    CONSTANT JZ : INTEGER = x"d0";
    CONSTANT JN : INTEGER = x"d1";
    CONSTANT JC : INTEGER = x"d2";
    CONSTANT JMP : INTEGER = x"d3";
    CONSTANT CALL : INTEGER = x"d4";
BEGIN
    PROCESS (IR)
    BEGIN
    END
END controle_unit_default; -- controle_unit_default