LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY Reg IS
  GENERIC (n : INTEGER := 32);
  PORT (
    clk, rst, enable : IN STD_LOGIC;
    d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
    q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0));
END Reg;

ARCHITECTURE a_Reg OF Reg IS
BEGIN
  PROCESS (clk, rst)
  BEGIN
    IF (enable = '0') THEN
      NULL;
    ELSIF (rst = '1') THEN
      q <= (OTHERS => '0');
    ELSIF clk'event AND clk = '1' THEN
      q <= d;
    END IF;
  END PROCESS;
END a_Reg;