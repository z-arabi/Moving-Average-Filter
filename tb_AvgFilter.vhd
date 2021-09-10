----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2019 08:02:45 PM
-- Design Name: 
-- Module Name: tb_AvgFilter - Behavioral
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
library ieee;
use ieee.std_logic_1164.all;
 
entity tb_AvgFilter is
  generic(num:integer:=8;
          win:integer:=4);
end entity;

architecture Behavioral of tb_AvgFilter is

signal out_signal,in_signal,max_val,min_val :std_logic_vector(15 downto 0):= (others => '0');
signal clk,start_in,reset,done:std_logic;
constant clk_period : time:= 80ns;

begin
uut:entity work.M_A(Behavioral)
    port map(in_signal => in_signal,
             out_signal => out_signal,
             max_val => max_val,
             min_val => min_val,
             clk => clk,
             reset => reset,
             done_out => done,
             start_in => start_in
             );
             
process
begin
clk <= '0';
wait for clk_period/2;
clk <= '1';
wait for clk_period/2;
end process;

process
begin
start_in <= '1';
wait for 70ns;
start_in <= '0';
wait for 70ns;
start_in <= '1';
wait for 1ms;
end process;

reset <= '1','0' after 50ns;

process
begin

wait for  150 ns;
    in_signal <= x"000A";
 wait for  100 ns;
    in_signal <= x"000B";
 wait for  100 ns;
    in_signal <= x"0008";
 wait for  100 ns;
    in_signal <= x"000D";
 wait for  100 ns;
    in_signal <= x"001A";
 wait for  100 ns;
    in_signal <= x"002A";
 wait for  100 ns;
    in_signal <= x"00A3";
 wait for  100 ns;
    in_signal <= x"004A";
 wait;
end process;
end Behavioral;
