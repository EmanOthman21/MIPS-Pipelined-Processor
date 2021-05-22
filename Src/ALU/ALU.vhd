Library ieee;
use ieee.std_logic_1164.all;

ENTITY alu IS
Generic ( n : Integer:=32);
  PORT (A,B : IN std_logic_vector (n-1 downto 0);
  selector : IN std_logic_vector (3 downto 0);
	cin: IN std_logic;
	F: OUT std_logic_vector (n-1 downto 0);
	cout : OUT std_logic);
END alu;

ARCHITECTURE a_alu OF alu IS
  component addernbit is
    PORT (x,y : IN   std_logic_vector (n-1 downto 0);
    cin: IN std_logic;
    s: OUT std_logic_vector (n-1 downto 0);
    cout : OUT std_logic);
  END component;

  -- Define signals
  Signal FADD, FSUB: std_logic_vector(n-1 DOWNTO 0);
  Signal FINC, FDEC, FINV : std_logic_vector(n-1 DOWNTO 0);
  Signal NEGB, ONE : std_logic_vector(n-1 DOWNTO 0);

  Signal CADD, CSUB : std_logic;
  Signal CINC, CDEC, CINV, CNEGB : std_logic;

  BEGIN
  -- logic
  FINV <= not B;
  ONE <= "0000000000000001";
  NegBAdder : addernbit GENERIC MAP (32) port map (FINV, ONE, '0', NEGB, CNEGB);
  -- A + B
  ADDER: addernbit GENERIC MAP (32) PORT MAP(A, B, '0', FADD, CADD);
  -- A - B = A + (-B)
  SUBBTRACTOR: addernbit GENERIC MAP (32) PORT MAP(A, NEGB, '0', FSUB, CSUB);
  -- B + 1
  INCREMENTOR: addernbit GENERIC MAP (32) PORT MAP(B, (others => '0'), '1', FINC, CINC);
  -- B - 1 = B + (-1)
  DECREMENTOR: addernbit GENERIC MAP (32) PORT MAP(B, (others => '1'), '0', FDEC, CDEC);

  -- map outputs
    F <= (others => '0') when selector = "0001"
    -- Not
    else FINV when selector = "0010"
    -- INC
    else FINC when selector = "0011"
    -- NEG
    else NEGB when selector = "0100"
    -- DEC
    else FDEC when selector = "0101"
    -- RLC
    else B(n-2 DOWNTO 0) & B(n-1) when selector = "0110"
    -- RRC
    else B(0) & B(n-1 DOWNTO 1) when selector = "0111"
    -- Move
    else A when selector = "1000"
    -- Add
    else FADD when selector = "1001" or selector = "1111"
    -- SUB
    else FSUB when selector = "1010"
    -- AND
    else (A and B) when selector = "1011"
    -- OR
    else (A or B) when selector = "1100";



    cout <= '0' when selector = "0001"
    else CINC when selector = "0011"
    else CNEGB when selector = "0100"
    else CDEC when selector = "0101"
    else B(n-1) when selector = "0110"
    else B(0) when selector = "0111"
    else CADD when selector = "1001" or selector = "1111"
    else CSUB when selector = "1010"
    else cin;

END a_alu;