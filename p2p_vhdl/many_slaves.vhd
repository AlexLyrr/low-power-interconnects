library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.DEMO_PACK.all;
use std.textio.all;
--use work.CONV_PACK_P2P_interconnect.all;

entity manyslaves is

port(

clk, reset: in std_logic;
	
data_out: out slave_master_data ;	


RW_in: in slave_master;
request_in: in slave_master;
data_in: in slave_master_data;
adress_in: in slave_master_adress

);



end manyslaves;


architecture a3 of manyslaves is



component slave is 

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
end component;







begin



arrayj: for i in number_of_slaves-1 downto 0 generate

		bw: slave
		generic map (
				
				file5 => read_inputs_files(i),
				file6 => output_files(i),
				file7 => output_adress_files(i)
				)
		port map(

			reset => reset,
			clk => clk,

			data_out =>data_out(i),			

			RW_in => RW_in(i),
			request_in => request_in(i),
			data_in => data_in(i),
			adress_in =>adress_in(i)
			
			);
		
		end generate arrayj;




end a3;















