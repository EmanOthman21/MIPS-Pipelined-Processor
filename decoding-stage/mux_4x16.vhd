LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;
ENTITY mux_4x16 IS
    PORT (
        selector : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        in0, in1, in2, in3, in4, in5, in6, in7, in8, in9 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        outData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END mux_4x16;

ARCHITECTURE mux_4x16_arch OF mux_4x16 IS

BEGIN
    PROCESS (selector, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9)
    BEGIN
        CASE(selector) IS

            WHEN "0000" => outData <= in0;
            WHEN "0001" => outData <= in1;
            WHEN "0010" => outData <= in2;
            WHEN "0011" => outData <= in3;
            WHEN "0100" => outData <= in4;
            WHEN "0101" => outData <= in5;
            WHEN "0110" => outData <= in6;
            WHEN "0111" => outData <= in7;
            WHEN "1000" => outData <= in8;
            WHEN "1001" => outData <= in9;
            WHEN OTHERS => outData <= in0;
        END CASE;
    END PROCESS;

END mux_4x16_arch; -- mux_4x16_arch