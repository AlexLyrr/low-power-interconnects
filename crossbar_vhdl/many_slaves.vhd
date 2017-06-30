library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.DEMO_PACK.all;
use std.textio.all;
--use work.CONV_PACK_crossbar_interconnect.all;

entity manyslaves is

port(

clk, reset: in std_logic;

data_out: out slave_data;


RW_in: in std_logic_vector(number_of_slaves-1 downto 0) ;
request_in: in slave_size;
data_in: in slave_data;
adress_in: in slave_adress


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
	
	
	-- data inputs and outputs
	
	-- read response 

data_out: out std_logic_vector (data_width downto 1) ;	

	-- service read/write requests


RW_in: in std_logic;
request_in: in std_logic;
data_in: in std_logic_vector (data_width-1 downto 0);
adress_in: in adress_size

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















