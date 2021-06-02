LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;
ENTITY demux_4x16 IS
    PORT (
        selector : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        inData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        out0, out1, out2, out3, out4, out5, out6, out7, out8, out9 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );

END demux_4x16;

ARCHITECTURE demux_4x16_arch OF demux_4x16 IS

BEGIN
    PROCESS (selector, inData)
    BEGIN
        CASE(selector) IS

            WHEN "0000" => out0 <= inData;
            WHEN "0001" => out1 <= inData;
            WHEN "0010" => out2 <= inData;
            WHEN "0011" => out3 <= inData;
            WHEN "0100" => out4 <= inData;
            WHEN "0101" => out5 <= inData;
            WHEN "0110" => out6 <= inData;
            WHEN "0111" => out7 <= inData;
            WHEN "1000" => out8 <= inData;
            WHEN "1001" => out9 <= inData;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;

END demux_4x16_arch; -- mux_4x16_arch