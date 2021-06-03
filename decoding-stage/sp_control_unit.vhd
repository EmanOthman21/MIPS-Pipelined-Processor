LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY sp_control_unit IS
    PORT (
        clk : IN STD_LOGIC;
        spOperationSelect : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        sp : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END sp_control_unit;
ARCHITECTURE sp_control_unit_arch OF sp_control_unit IS

BEGIN
    sp <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(sp)) + 2, 32)) WHEN (spOperationSelect = "01") ELSE
        STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(sp)) - 2, 32)) WHEN (spOperationSelect = "10")
        ELSE
        sp;

END sp_control_unit_arch; -- sp_control_unit_arch