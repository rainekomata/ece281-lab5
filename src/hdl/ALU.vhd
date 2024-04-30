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
	process(i_A, i_B, i_op)
	begin
	o_result <= i_A + i_B when (i_op = "000") else --addition
	            i_A - i_B when (i_op = "001") else -- subtraction
	            i_A or i_B when (i_op = "100" or i_op = "101") else -- or
	            i_A and i_B when (i_op = "010" or i_op = "011") else -- and 
	            STD_LOGIC_VECTOR(unsigned(i_A) sll i_B(2 downto 0)) when (i_op = "111") else -- left logical shift
	            STD_LOGIC_VECTOR(unsigned(i_A) srl i_B(2 downto 0)); -- right logical shift
	end process;
	            
    case i_op is
                    when "001" =>
                        o_result <= i_A - i_B;
                        o_flag <= "010" when (i_A < i_B) else "000";
                    when "100" | "101" =>
                        o_result <= i_A or i_B;
                        o_flag <= "000";
                    when "010" | "011" =>
                        o_result <= i_A and i_B;
                        o_flag <= "000";
                    when "111" =>
                        o_result <= STD_LOGIC_VECTOR(unsigned(i_A) sll i_B(2 downto 0));
                        o_flag <= "000";
                    when "110" =>
                        o_result <= STD_LOGIC_VECTOR(unsigned(i_A) srl i_B(2 downto 0));
                        o_flag <= "000";
                    when others =>
                        o_result <= (others => '0');
                        o_flag <= "000";
                end case;
                
	    	    
	
    o_flag <= "100" when (i_op = "000") and ((i_A) + unsigned(i_B) > 255) else
                          "000";

	            
	            
	            
	               

	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	
	
end behavioral;
