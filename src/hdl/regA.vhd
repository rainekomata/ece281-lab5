----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2024 09:39:43 PM
-- Design Name: 
-- Module Name: regA - Behavioral
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
-- 
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

entity regA is
    Port ( 
           i_clk : in STD_LOGIC;
           i_A : in STD_LOGIC_VECTOR (7 downto 0);
           o_A : out STD_LOGIC_VECTOR (7 downto 0)
           );
end regA;

architecture Behavioral of regA is

begin
    process (i_clk)
    begin
        if (rising_edge(i_clk)) then
            o_A <= i_A;
        end if;
    end process;

end Behavioral;
