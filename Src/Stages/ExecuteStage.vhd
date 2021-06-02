library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY execute_stage IS
Generic ( n : Integer:=32);
  PORT (Rdest,Rsrc : IN std_logic_vector (n-1 downto 0);
  memOut,aluOut : IN std_logic_vector (n-1 downto 0);
  inPort,offset : IN std_logic_vector (n-1 downto 0);
  flagRegIn: IN std_logic_vector (2 downto 0);
  RdestNumID,RsrcNumID,RdestNumMem,RdestNumEX : IN std_logic_vector (3 downto 0);
	wbEX,wbMem: IN std_logic;
  control: IN std_logic_vector (20 downto 0);
	RdestOutEX, aluOutEX, outPort : OUT std_logic_vector (n-1 downto 0);
  RdestNum: OUT std_logic_vector (3 downto 0);
  controlOut: OUT std_logic_vector (20 downto 0);
  flagOut: OUT std_logic_vector (2 downto 0)
  );
END execute_stage;

ARCHITECTURE executeArch OF execute_stage is
  ---------------------
  -- Components
  ---------------------
  COMPONENT alu is
    PORT (A,B : IN std_logic_vector (n-1 downto 0);
    selector : IN std_logic_vector (3 downto 0);
    cin: IN std_logic;
    F: OUT std_logic_vector (n-1 downto 0);
    cout : OUT std_logic);
  END COMPONENT;

  COMPONENT forwarding is
    PORT (srcNumID, destNumEX,destNumMem : IN std_logic_vector (3 downto 0);
    wbEX,wbMem: IN std_logic;
    selector: OUT std_logic_vector (1 downto 0));
  END COMPONENT;

  COMPONENT flag IS
    PORT ( cin, changeEnable,setCarry,clrCarry: IN std_logic;
    inFlag: IN std_logic_vector (2 downto 0);
    F: IN std_logic_vector(15 downto 0);
    outFlag: OUT std_logic_vector (2 downto 0));
  END COMPONENT;


  ---------------------
  -- Signals
  ---------------------
  Signal writeFlags, writeOut, immediate, readInputPort,aluCout: std_logic;
  Signal setCarry,clrCarry: std_logic;
  Signal aluSelect : std_logic_vector(3 downto 0);
  Signal srcIn, forwardedDest, aluIn1, aluIn2,aluTemp: std_logic_vector(n-1 downto 0);
  Signal inSel1,inSel2 : std_logic_vector(1 DOWNTO 0);

	BEGIN
    writeFlags <= control(3);
    writeOut <= control(10);
    readInputPort <= control(11);
    aluSelect <= control(15 downto 12);
    clrCarry <= control(16);
    setCarry <= control(17);
    immediate <= control(18);


    srcIn <= inPort when readInputPort = '1'
    else Rsrc;

    SelIn1: forwarding PORT MAP(RsrcNumID,RdestNumEX,RdestNumMem,wbEX,wbMem,inSel1);
    SelIn2: forwarding PORT MAP(RdestNumID,RdestNumEX,RdestNumMem,wbEX,wbMem,inSel2);

    aluIn1 <= memOut when inSel1 = "01"
    else aluOut when inSel1 = "10"
    else srcIn;

    forwardedDest <= memOut when inSel2 = "01"
    else aluOut when inSel2 = "10"
    else Rdest;

    aluIn2 <= offset when immediate = '1'
    else forwardedDest;

    aluComp: alu GENERIC MAP (32) PORT MAP(aluIn1,aluIn2,aluSelect,flagRegIn(2),aluTemp,aluCout);

    flagComp: flag PORT MAP(aluCout,writeFlags,setCarry,clrCarry,flagRegIn,aluTemp,flagOut);

    aluOutEx <= aluTemp;
    outPort <= forwardedDest when writeOut = '1';
    RdestOutEX <= forwardedDest;
    controlOut <= control;
    RdestNum <= RdestNumID;

END executeArch;