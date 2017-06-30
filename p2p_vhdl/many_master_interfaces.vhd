library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity manymasters_interface is

port(

data_in: in master_data;
RW_in:in std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
adress_in: in master_adress;
request_in: in master_slave;


data_out: out master_slave_data ; 					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
RW_out:out master_slave; -- read = 1 , write = 0			-- type of request
adress_out: out master_slave_adress;
request_out: out master_slave;


data_fromSI: in master_slave_data; 
adress_fromSI:in master_slave_adress;
read_data_responsefromSI:in master_slave ;	

data_toM: out master_slave_data; 
adress_toM:out master_slave_adress;
read_data_responsetoM: out master_slave

);



end manymasters_interface;


architecture a3 of manymasters_interface is


component master_interface

port (
	
	-- data inputs and outputs
	
	-- request write/read ports


data_in: in std_logic_vector (data_width downto 1) ; 					
RW_in:in std_logic ; -- read = 1 , write = 0			
adress_in: in adress_size;
request_in: in slave_size;
							

data_out: out slave_data ; 					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
RW_out:out std_logic_vector(number_of_slaves-1 downto 0) ; -- read = 1 , write = 0			-- type of request
adress_out: out slave_adress;
request_out: out slave_size;


-----FROM SLAVE FABRIC TO MASTER

data_fromSI: in slave_data; 
adress_fromSI:in slave_adress;
read_data_responsefromSI:in std_logic_vector (number_of_slaves-1 downto 0) ;	

data_toM: out slave_data; 
adress_toM:out slave_adress;
read_data_responsetoM: out std_logic_vector (number_of_slaves-1 downto 0) 	
-----------


);

end component;




begin


arrayi: for i in number_of_masters-1 downto 0 generate

		sw: master_interface
		port map(
		
			data_in => data_in(i),
			RW_in => RW_in(i),
			adress_in => adress_in(i),
			request_in => request_in(i),
			
			data_out => data_out(i),
			RW_out => RW_out(i),
			request_out => request_out(i),
			adress_out => adress_out(i),

			data_fromSI => data_fromSI(i) ,
			adress_fromSI =>adress_fromSI(i),
			read_data_responsefromSI =>read_data_responsefromSI(i),

			data_toM =>data_toM(i),
			adress_toM =>adress_toM(i),
			read_data_responsetoM =>read_data_responsetoM(i)

			);
		
		end generate arrayi;




end a3;















