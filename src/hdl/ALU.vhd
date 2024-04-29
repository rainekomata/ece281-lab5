--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
--|
--| ALU OPCODES:
--|
--|     ADD     000
--|     SUB     001
--|     OR      100
--|     OR      101
--|     AND     010
--|     AND     011
--|     L SHIFT 111
--|     R SHIFT 110
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity ALU is
    port ( i_op     : in STD_LOGIC_VECTOR (2 downto 0);
           i_A      : in STD_LOGIC;
           i_B      : in STD_LOGIC;
           
           o_flag   : out STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0)
         );
end ALU;

architecture behavioral of ALU is 
  
	-- declare components and signals
	signal w_posNeg        : STD_LOGIC_VECTOR (7 downto 0);
	signal w_add           : STD_LOGIC_VECTOR (7 downto 0);
	signal w_cOut          : STD_LOGIC;
	signal w_and           : STD_LOGIC_VECTOR (7 downto 0);
	signal w_or            : STD_LOGIC_VECTOR (7 downto 0);
	signal w_rightShift    : STD_LOGIC_VECTOR (7 downto 0);
	signal w_leftShift     : STD_LOGIC_VECTOR (7 downto 0);
	signal w_shift         : STD_LOGIC_VECTOR (7 downto 0);
	signal w_result        : STD_LOGIC_VECTOR (7 downto 0);
  
begin
	-- PORT MAPS ----------------------------------------

	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	
	
end behavioral;
