LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;
ENTITY register_file IS
    PORT (
        IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RdstNewValue : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        spOperationSelector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

        offset : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rdst : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Rsrc : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        RdstNum : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RsrcNum : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END register_file;

ARCHITECTURE register_file_architecture OF register_file IS

    SIGNAL R0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R3 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R4 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R5 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R6 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL R7 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL pc : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL sp : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL tempRdst : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL tempRsrc : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    -- rdst mux
    rdst_mux_lbl :
    ENTITY work.mux_4x16 PORT MAP (IR(23 DOWNTO 20), R0, R1, R2, R3, r4, R5, R6, R7, pc, sp, tempRdst);
    -- rsrc mux
    rsrc_mux_lbl : ENTITY work.mux_4x16 PORT MAP (IR(19 DOWNTO 16), R0, R1, R2, R3, r4, R5, R6, R7, pc, sp, tempRsrc);

    -- sp control unit 
    sp_control_unit_lbl : ENTITY work.sp_control_unit PORT MAP(spOperationSelector, sp);
    decding : PROCESS (IR)
    BEGIN
        -- sign extend offset 
        offset <= STD_LOGIC_VECTOR(resize(signed(IR(15 DOWNTO 0)), 32));

        RdstNum <= IR(23 DOWNTO 20);
        RsrcNum <= IR(19 DOWNTO 16);
        Rdst <= tempRdst;
        Rsrc <= tempRsrc;

    END PROCESS; -- decding

END register_file_architecture;