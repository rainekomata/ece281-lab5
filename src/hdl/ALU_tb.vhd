----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2024 10:49:58 PM
-- Design Name: ECE281 Lab 5
-- Module Name: ALU_tb - Behavioral
-- Project Creators: C3C Raine Komata and C3C Megan Leong 
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

entity ALU_tb is
end ALU_tb;

architecture test_bench of ALU_tb is
    component ALU is
        port ( i_op     : in STD_LOGIC_VECTOR (2 downto 0);
               i_A      : in STD_LOGIC_VECTOR (8 downto 0);
               i_B      : in STD_LOGIC_VECTOR (8 downto 0);
               
               o_flag   : out STD_LOGIC_VECTOR (2 downto 0);
               o_result : out STD_LOGIC_VECTOR (8 downto 0)
             );
    end component ALU;
    
    -- declare components and signals
        signal w_add           : STD_LOGIC_VECTOR (8 downto 0);
        signal w_negPosB       : STD_LOGIC_VECTOR (8 downto 0);
        signal w_carry         : STD_LOGIC;
        signal w_and           : STD_LOGIC_VECTOR (8 downto 0);
        signal w_or            : STD_LOGIC_VECTOR (8 downto 0);
        signal w_rightShift    : STD_LOGIC_VECTOR (8 downto 0);
        signal w_leftShift     : STD_LOGIC_VECTOR (8 downto 0);
        signal w_shift         : STD_LOGIC_VECTOR (8 downto 0);
        signal w_result        : STD_LOGIC_VECTOR (8 downto 0);
        signal w_zero          : STD_LOGIC;
        signal w_sign          : STD_LOGIC;
        
        signal w_op, w_flag : STD_LOGIC_VECTOR (2 downto 0);
        signal w_A, w_B : STD_LOGIC_VECTOR (8 downto 0);

begin

-- Port Maps
uut: ALU
port map (
    i_op => w_op,
    i_A => w_A,
    i_B => w_B,
    o_result => w_result,
    o_flag => w_flag
);

-- Simulation process
sim_proc: process
begin

-- 0 + 1 = 1, no carry
w_op <= "000"; w_A <= "00000000"; w_B <= "00000001";
    assert w_result = "000000001" report "addition failed" severity failure;
    assert w_flag(0) = '0' report "sign wrong (addition)" severity failure;

-- 0 - (127) = -127, 
w_op <= "001"; w_A <= "00000000"; w_B <= "11111111";
    assert w_result = "10000001" report "subtraction failed" severity failure;
    assert w_flag(0) = '0' report "sign wrong (addition)" severity failure;
    end;   

-- and, or, shift left, shift right, addition with/without carry

end test_bench;
