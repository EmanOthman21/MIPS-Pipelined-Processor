LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY alu IS
  GENERIC (n : INTEGER := 32);
  PORT (
    A, B : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    selector : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    cin : IN STD_LOGIC;
    F : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    flagOut : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
    cout : OUT STD_LOGIC);
END alu;

ARCHITECTURE a_alu OF alu IS
  COMPONENT addernbit IS
    PORT (
      x, y : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
      cin : IN STD_LOGIC;
      s : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
      cout : OUT STD_LOGIC);
  END COMPONENT;

  -- Define signals
  SIGNAL FADD, FSUB : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
  SIGNAL FINC, FDEC, FINV : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
  SIGNAL NEGB, ONE : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
  SIGNAL LEFTB, RIGHTB : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
  SIGNAL CADD, CSUB : STD_LOGIC;
  SIGNAL CINC, CDEC, CINV, CNEGB : STD_LOGIC;
BEGIN
  -- logic
  FINV <= NOT B;
  ONE <= "00000000000000000000000000000001";
  NegBAdder : addernbit GENERIC MAP(32) PORT MAP(FINV, ONE, '0', NEGB, CNEGB);
  -- A + B
  ADDER : addernbit GENERIC MAP(32) PORT MAP(A, B, '0', FADD, CADD);
  -- A - B = A + (-B)
  SUBBTRACTOR : addernbit GENERIC MAP(32) PORT MAP(A, NEGB, '0', FSUB, CSUB);
  -- B + 1
  INCREMENTOR : addernbit GENERIC MAP(32) PORT MAP(B, (OTHERS => '0'), '1', FINC, CINC);
  -- B - 1 = B + (-1)
  DECREMENTOR : addernbit GENERIC MAP(32) PORT MAP(B, (OTHERS => '1'), '0', FDEC, CDEC);
  -- Shift left
  LEFTB <= STD_LOGIC_VECTOR(shift_left(unsigned(A), to_integer(unsigned(B))));
  RIGHTB <= STD_LOGIC_VECTOR(shift_right(unsigned(A), to_integer(unsigned(B))));
  -- map outputs
  F <= (OTHERS => '0') WHEN selector = "0001"
    -- Not
    ELSE
    FINV WHEN selector = "0010"
    -- INC
    ELSE
    FINC WHEN selector = "0011"
    -- NEG
    ELSE
    NEGB WHEN selector = "0100"
    -- DEC
    ELSE
    FDEC WHEN selector = "0101"
    -- RLC
    ELSE
    B(n - 2 DOWNTO 0) & cin WHEN selector = "0110"
    -- RRC
    ELSE
    cin & B(n - 1 DOWNTO 1) WHEN selector = "0111"
    -- Move
    ELSE
    A WHEN selector = "1000"
    -- Add
    ELSE
    FADD WHEN selector = "1001"
    -- SUB
    ELSE
    FSUB WHEN selector = "1010"
    -- AND
    ELSE
    (A AND B) WHEN selector = "1011"
    -- OR
    ELSE
    (A OR B) WHEN selector = "1100"
    -- SHL
    ELSE
    LEFTB WHEN selector = "1101"
    -- SHR
    ELSE
    RIGHTB WHEN selector = "1110"
    ELSE
    B;

  cout <= CINC WHEN selector = "0011"
    ELSE
    CNEGB WHEN selector = "0100"
    ELSE
    CDEC WHEN selector = "0101"
    ELSE
    B(n - 1) WHEN selector = "0110" OR selector = "1101"
    ELSE
    B(0) WHEN selector = "0111" OR selector = "1110"
    ELSE
    CADD WHEN selector = "1001"
    ELSE
    CSUB WHEN selector = "1010"
    ELSE
    cin;

END a_alu;