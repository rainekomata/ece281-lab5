----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 08:18:15 PM
-- Design Name: 
-- Module Name: controller_fsm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Documentation Statement: None
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
    port(
        i_reset   : in std_logic;
        i_adv     : in std_logic;
        i_clk     : in std_logic;
        o_cycle   : out std_logic_vector (3 downto 0)
      );
end controller_fsm;

architecture Behavioral of controller_fsm is
    signal f_Q, f_Q_next: std_logic_vector(3 downto 0) := "0001"; 

begin
f_Q_next <= "0001" when ((f_Q = "1000") and (i_adv = '1')) else 
            "1000" when ((f_Q = "0100") and (i_adv = '1')) else 
            "0100" when ((f_Q = "0010") and (i_adv = '1')) else 
            "0010" when ((f_Q = "0001") and (i_adv = '1')) else 
            f_Q;
o_cycle <= f_Q;
               
	register_proc : process (i_clk, i_reset)
       begin
           if(rising_edge(i_clk)) then
           if i_reset = '1' then
                f_Q <= "0001";
                else 
                    f_Q <= f_Q_next;
           end if;
           end if;
     end process register_proc;    

end Behavioral;
