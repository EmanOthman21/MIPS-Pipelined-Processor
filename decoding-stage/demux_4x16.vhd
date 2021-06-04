LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;
ENTITY demux_4x16 IS
    PORT (
        clk, RESET ,enable: IN STD_LOGIC;
        selector : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        inData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        out0, out1, out2, out3, out4, out5, out6, out7, out8, out9 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );

END demux_4x16;

ARCHITECTURE demux_4x16_arch OF demux_4x16 IS

BEGIN
    out0 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0000" and enable='1');
    out1 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0001" and enable='1');
    out2 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0010" and enable='1');
    out3 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0011" and enable='1');
    out4 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0100" and enable='1');
    out5 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0101" and enable='1');
    out6 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0110" and enable='1');
    out7 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "0111" and enable='1');
    out8 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "1000" and enable='1');
    out9 <= (OTHERS => '0') WHEN (RESET = '1') ELSE
        inData WHEN (selector = "1001" and enable='1');

END demux_4x16_arch; -- mux_4x16_arch