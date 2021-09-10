----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2019 06:30:40 PM
-- Design Name: 
-- Module Name: testFreqDivider - Behavioral
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

entity testFreqDivider is
  generic(
      Div : integer := 5);
--  Port ( );
end testFreqDivider;

architecture Behavioral of testFreqDivider is
 signal clk,reset,tick : std_logic := '0';
 signal dvsr : std_logic_vector(Div-1 downto 0) := (others=>'0');
 constant clk_per : time:=100ns;
 
begin
 uut: entity work.frequency_divider(Behavioral)
  port map(clk => clk,
          reset => reset,
          dvsr => dvsr,
          tick => tick);
          
process
begin
clk <= '0' ;
wait for clk_per/2;
clk <= '1';
wait for clk_per/2;
end process;
          
reset <= '1','0' after 130ns;

process
begin
dvsr <= std_logic_vector(to_unsigned(Div,Div));
wait;
end process;

end Behavioral;
