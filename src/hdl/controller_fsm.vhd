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
        o_cycle   : out std_logic_vector (3 downto 0)
      );
end controller_fsm;

architecture Behavioral of controller_fsm is
    type sm_cycle is (s0,s1,s2,s3);
    signal f_Q, f_Q_next: sm_cycle;


begin
f_Q_next <= s0 when ((f_Q = s0) and (i_adv = '0')) else 
            s0 when ((f_Q = s3) and (i_adv = '0' or i_adv = '1')) else
            s1 when ((f_Q = s0) and (i_adv = '1')) else
            s1 when ((f_Q = s1) and (i_adv = '0')) else
            s2 when ((f_Q = s2) and (i_adv = '0')) else
            s2 when ((f_Q = s1) and (i_adv = '1')) else
            s3 when ((f_Q = s2) and (i_adv = '1')) else
            f_Q;
with f_Q select
    o_cycle <= "0001" when s0,
               "0010" when s1,
               "0100" when s2,
               "1000" when s3;
               
	register_proc : process (i_adv)
       begin
            -- synchronous reset
           if i_reset = '1' then
                f_Q <= s0;
           elsif i_adv = '1' then
                f_Q <= f_Q_next; 
           end if;
       end process register_proc;    
end Behavioral;
