library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.DEMO_PACK.all;
use std.textio.all;
--use work.CONV_PACK_P2P_interconnect.all;

entity slave is 

generic(

	file5: string :="C:\Users\Alex\Desktop\inputs\read.data0.txt";

	file6: string  := "C:\Users\Alex\Desktop\outputs\output.data0.txt";

	file7: string :="C:\Users\Alex\Desktop\outputs\adress.data0.txt"
	
	

                    );


port (
	clk, reset: in std_logic;
	
	
data_out: out master_data ;	


RW_in: in std_logic_vector (number_of_masters-1 downto 0);
request_in: in std_logic_vector (number_of_masters-1 downto 0);
data_in: in master_data;
adress_in: in master_adress

);

end slave;

architecture a2 of slave is

file stimulus5: TEXT open read_mode is file5;

file stimulus6: TEXT open write_mode is file6;

file stimulus7: TEXT open write_mode is file7;


signal help_read: std_logic_vector (number_of_masters-1 downto 0) :=  (number_of_masters-1 downto 0 => '0');
signal data_help_read:std_logic_vector (data_width downto 1) := (data_width downto 1 => '0');		




begin


-- RECEIVE DATA PROCESS ,when master is a temporary a slave and receives data.

receive_data: process(clk,reset)		

variable l: line;
variable l2: line;
variable s5: string(data_help_read'range);

begin

if reset ='0' then
	help_read <= (others=> '0');
	for i in 0 to number_of_masters-1  loop
		data_out(i) <= (others=> '0');
	end loop;
else
                                    

if (clk'event and clk='1') then
		if (clk'event and clk='1') then
			for i in 0 to number_of_masters-1 loop

			if request_in(i) = '1' and RW_in(i) = '0' then
				print(stimulus7,str(adress_in(i)));
				print(stimulus6,str(data_in(i)));
			
			elsif request_in(i) = '1' and RW_in(i) = '1' then
				readline(stimulus5, l2);
				read(l2, s5);
				data_out(i) <= to_std_logic_vector(s5);

			end if;

			end loop;
		
		end if;
end if;
end if;

end process receive_data;


end a2;
