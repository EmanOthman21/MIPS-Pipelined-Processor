LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mux_2_1_mod IS
    PORT (
        selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        muxIn1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        muxIn2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        muxOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END mux_2_1_mod;

ARCHITECTURE mux_logic OF mux_2_1_mod IS
BEGIN
    muxOut <= muxIn2 WHEN selector = "10" ELSE
        muxIn1 WHEN selector = "01";
END mux_logic;