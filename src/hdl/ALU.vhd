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
           i_A      : in STD_LOGIC_VECTOR (7 downto 0);
           i_B      : in STD_LOGIC_VECTOR (7 downto 0);
           o_flag   : out STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0)
         );
end ALU;
 
architecture behavioral of ALU is 
	-- declare components and signals
	signal w_add           : STD_LOGIC_VECTOR (8 downto 0);
	signal w_negPosB       : STD_LOGIC_VECTOR (7 downto 0);
	signal w_carry         : STD_LOGIC;
	signal w_and           : STD_LOGIC_VECTOR (7 downto 0);
	signal w_or            : STD_LOGIC_VECTOR (7 downto 0);
	signal w_rightShift    : STD_LOGIC_VECTOR (7 downto 0);
	signal w_leftShift     : STD_LOGIC_VECTOR (7 downto 0);
	signal w_shift         : STD_LOGIC_VECTOR (7 downto 0);
	signal w_result        : STD_LOGIC_VECTOR (7 downto 0);
	signal w_zero          : STD_LOGIC;
	signal w_sign          : STD_LOGIC;
begin
	-- PORT MAPS ----------------------------------------
 
       w_negPosB <= STD_LOGIC_VECTOR(NOT(signed(i_B)) + signed(i_op)) when i_op(0) = '1' else --poisitive or negative B
                    STD_LOGIC_VECTOR(signed(i_B)) when i_op(0) = '0';
       w_add <= STD_LOGIC_VECTOR(signed('0' & i_A) + signed(w_negPosB)); --addition
       w_carry <= w_add(8); 
       w_and <= i_A AND i_B;
       w_or <= i_A OR i_B;
       w_shift <= w_rightShift when i_op(0) = '0' else 
                  w_leftShift when i_op(0) = '1';
       w_rightShift <= STD_LOGIC_VECTOR(shift_right(unsigned(i_A), to_integer(unsigned(i_B(2 downto 0)))));
       w_leftShift <= STD_LOGIC_VECTOR(shift_left(unsigned(i_A), to_integer(unsigned(i_B(2 downto 0)))));
       w_result <= w_add(7 downto 0) when i_op(2 downto 1) = "00" else 
                   w_and when i_op(2 downto 1) = "01" else 
                   w_or when i_op(2 downto 1) = "10" else 
                   w_shift when i_op(2 downto 1) = "11";
--       w_carry <= '1' when (i_op = "000" AND (STD_LOGIC_VECTOR(unsigned(i_A) + unsigned(i_B)) > "11111111")) else
--                          '0';
       w_zero <= '1' when w_result = "000000000" else '0';
       w_sign <= '1' when w_result(7) = '1' else '0';
	    --p. 244: adder
	-- CONCURRENT STATEMENTS ----------------------------
	o_result <= w_result;
	o_flag(0) <= w_sign; 
	o_flag(2) <= w_carry;
	o_flag(1) <= w_zero;	               

end behavioral;