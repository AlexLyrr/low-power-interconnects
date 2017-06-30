library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.DEMO_PACK.all;
use std.textio.all;
--use work.CONV_PACK_P2P_interconnect.all;

entity manymasters is

port(

clk, reset: in std_logic;

data_out: out master_data;
request_out: out master_slave;
RW_out:out std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0

adress_out: out master_adress;

Read_response: in master_slave;		-- if a slave send data back to the master(respond to a data request) then read_response is set to '1'
data_in: in master_slave_data;
adress_in: in master_slave_adress

);



end manymasters;


architecture a3 of manymasters is


component master

generic(
	file1: string :="C:\Users\Alex\Desktop\inputs\input.data0.txt";		-- files for inputs/destinations/time/ReadOrWriteBit/ReadInputs/WriteOutputs
	file2: string :="C:\Users\Alex\Desktop\destis\desti.data0.txt";
	file3: string :="C:\Users\Alex\Desktop\time\time.data0.txt";
	file4: string :="C:\Users\Alex\Desktop\read_write\read_write.data0.txt";

	file5:string :="C:\Users\Alex\Desktop\adress\adress.data0.txt";

	
	file6: string  := "C:\Users\Alex\Desktop\outputs\output.data0.txt"
	

                    );


port (
	clk, reset: in std_logic;
	
	
	-- data inputs and outputs
	
	-- request write/read ports

									--then the master noticed it throught this variable

data_out: out std_logic_vector (data_width downto 1) ; 	
request_out: out slave_size ;					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
RW_out:out std_logic ; -- read = 1 , write = 0			-- type of request
adress_out: out adress_size;

	-- read request response


Read_response: in std_logic_vector (number_of_slaves-1 downto 0) ;					-- if a slave send data back to the master(respond to a data request) then read_response is set to '1'
data_in: in slave_data;
adress_in: in slave_adress


);


end component;




begin


arrayi: for i in number_of_masters-1 downto 0 generate

		sw: master
		generic map (
				file1 => input_files(i) ,
				file2 => desti_files(i),
				file3 => time_files(i),
				file4 => RW_files(i),
				file5 => adress_files(i),

				file6 => memory_files(i)
				)
		port map(
			reset => reset,
			clk => clk,
			
			data_out => data_out(i),
			request_out => request_out(i),
			RW_out => RW_out(i),
			adress_out => adress_out(i),
			-- service read/write requests
			

			Read_response => read_response(i),	
			data_in => data_in(i),
			adress_in => adress_in(i)

			);
		
		end generate arrayi;




end a3;















