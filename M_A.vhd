----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/22/2019 11:26:59 AM
-- Design Name: 
-- Module Name: M_A - Behavioral
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

entity M_A is
    generic(num:integer:=8;
            win:integer:=4);
            
    Port ( start_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           in_signal : in STD_LOGIC_VECTOR (15 downto 0);
           done_out : out STD_LOGIC;
           max_val : out STD_LOGIC_VECTOR (15 downto 0);
           min_val : out STD_LOGIC_VECTOR (15 downto 0);
           out_signal : out STD_LOGIC_VECTOR (15 downto 0)
           );
end M_A;

architecture Behavioral of M_A is
type my_reg is array(num-1 downto 0) of std_logic_vector(15 downto 0);
signal reg: my_reg :=(others=>(others=>'0'));
type state_type is (idle,start,data,done);
signal state : state_type; 
signal cn,cm,av:integer:= 0;
signal co,co2:natural;
signal min,max : std_logic_vector(15 downto 0);
begin

process(clk)
begin
if(clk'event and clk='1') then
    if(reset = '1') then
        state <= idle;
        reg <= (others=>(others=>'0'));
        done_out <= '0';
        out_signal <= (others=>'0');
        max <= (others=>'0');
        min <= (others=>'0');
        cn <= 1;
        cm <= 0;
        
    else
        case state is
            when idle => 
                if(start_in = '0') then
                    state <= start;
                end if;
            when start =>
                if(start_in = '1') then
                    state <= data;
                    reg(0) <= in_signal;
                    max <= in_signal;
                    min <= in_signal;
                    co <= to_integer(unsigned(in_signal));
                    co2 <= co/win;
                    out_signal <= std_logic_vector(to_unsigned(co2,16));
                end if;
            when data =>
                 if( cn < num ) then
                    reg(cn) <= in_signal;
                    cn <= cn + 1;
                    if(cm < win) then
                        co <= to_integer(unsigned(in_signal))+ co;
                        cm <= cm + 1;
                    elsif( cm > win-1 and cm < num ) then 
                        co <= co + to_integer(unsigned(in_signal))- to_integer(unsigned(reg(cm-win)));
                        cm <= cm + 1;
                    else
                        cm <= 0;
                    end if;   
                 elsif(cn>=num)then
                    state <= done;
                    done_out <= '1';                 
                 end if;
                 
                co2 <= co/win;
                out_signal <= std_logic_vector(to_unsigned(co2,16));
                
                if(in_signal > max) then
                    max <= in_signal;
                elsif(in_signal < min)then
                    min <= in_signal;
                end if;
                
            when done =>
                 done_out <= '0';
                 state <= idle;
                 out_signal <= (others=>'0');
                 max <= (others=>'0');
                 min <= (others=>'0');
                 cn <= 1;
                 cm <= 0;
                
         end case;  
    end if;

end if;
end process;

min_val <= min;
max_val <= max;

end Behavioral;
