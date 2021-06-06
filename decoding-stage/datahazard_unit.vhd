LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY DataHazardUnit IS
    PORT (
        immFlag : IN STD_LOGIC;
        rsrc : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        rdstMEMWB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        rdstEXMEM : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        rdstWBSeclectorMEMWB : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        rdstWBSeclectorEXMEM : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        in1Mux : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        in2Mux : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END DataHazardUnit;

ARCHITECTURE DataHazardUnitDefault OF DataHazardUnit IS
BEGIN
    PROCESS (immFlag, rsrc, rdstMEMWB, rdstEXMEM, rdstWBSeclectorMEMWB, rdstWBSeclectorEXMEM)
    BEGIN
        IF (rdstMEMWB /= rsrc AND rdstEXMEM /= rsrc) OR (rdstWBSeclectorMEMWB = "00" AND rdstWBSeclectorEXMEM = "00") THEN
            in1Mux <= "00";
        ELSIF ((rdstMEMWB = rsrc AND rdstEXMEM /= rsrc) AND (rdstWBSeclectorMEMWB /= "00")) OR (((rdstMEMWB = rsrc AND rdstEXMEM = rsrc) AND (rdstWBSeclectorMEMWB /= "00" AND rdstWBSeclectorEXMEM = "00"))) THEN
            in1Mux <= "01";

        ELSIF ((rdstMEMWB = rsrc AND rdstEXMEM = rsrc) AND (rdstWBSeclectorEXMEM /= "00")) OR ((rdstMEMWB /= rsrc AND rdstEXMEM = rsrc) AND (rdstWBSeclectorMEMWB = "00" AND rdstWBSeclectorEXMEM /= "00")) THEN
            in1Mux <= "10";
        END IF;

        -- more readable approach for in2Mux
        IF rdstMEMWB /= rsrc AND rdstEXMEM /= rsrc AND immFlag = '0' THEN
            in2Mux <= "00";
        ELSIF rdstMEMWB /= rsrc AND rdstEXMEM /= rsrc AND immFlag = '1' THEN
            in2Mux <= "01";
        ELSIF rdstWBSeclectorMEMWB = "00" AND rdstWBSeclectorEXMEM = "00" AND immFlag = '0' THEN
            in2Mux <= "00";
        ELSIF rdstWBSeclectorMEMWB = "00" AND rdstWBSeclectorEXMEM = "00" AND immFlag = '1' THEN
            in2Mux <= "01";
        ELSIF rdstMEMWB = rsrc AND rdstEXMEM /= rsrc AND rdstWBSeclectorMEMWB /= "00" THEN
            in2Mux <= "10";
        ELSIF rdstMEMWB /= rsrc AND rdstEXMEM = rsrc AND rdstWBSeclectorEXMEM /= "00" THEN
            in2Mux <= "11";
        ELSIF rdstMEMWB = rsrc AND rdstEXMEM = rsrc AND rdstWBSeclectorEXMEM = "00" AND rdstWBSeclectorMEMWB /= "00" THEN
            in2Mux <= "10";
        ELSIF rdstMEMWB = rsrc AND rdstEXMEM = rsrc AND rdstWBSeclectorEXMEM /= "00" AND rdstWBSeclectorMEMWB = "00" THEN
            in2Mux <= "11";
        END IF;
    END PROCESS;

END DataHazardUnitDefault; -- DataHazardUnitDefault