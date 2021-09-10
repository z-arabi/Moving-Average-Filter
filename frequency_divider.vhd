----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2019 06:09:48 PM
-- Design Name: 
-- Module Name: frequency_divider - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frequency_divider is
    generic(
      Div : integer := 5);
      
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           dvsr : in STD_LOGIC_VECTOR (Div-1 downto 0);
           tick : out STD_logic );
end frequency_divider;

architecture Behavioral of frequency_divider is
 signal r_reg,r_next : unsigned(Div-1 downto 0) ;
 signal c_reg,c_next : unsigned(1 downto 0);
begin
 process(clk,reset)
 begin
  if(reset='1')then
   r_reg <= (others=>'0');
   c_reg <= "00" ;
  elsif(clk='1' or clk='0') then
   r_reg <= r_next; 
   c_reg <= c_next;
  end if;
 end process;
 
 r_next <= (others =>'0') when r_reg=unsigned(dvsr)-1 else r_reg+1;
 c_next <= c_reg+1 when(r_reg = unsigned(dvsr)-1)else
           "00" when (c_reg = "10") else
           c_reg;

 tick <='1' when (c_reg = "01") else
        '0';
         
end Behavioral;