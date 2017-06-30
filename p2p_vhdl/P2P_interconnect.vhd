library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;
--use work.CONV_PACK_crossbar_interconnect.all;


entity P2P_interconnect is

port
(

signal clk,reset:in std_logic ;

data_in_masterinterfaces:in master_data;
RW_in_masterinterfaces:in std_logic_vector(number_of_masters-1 downto 0); 
adress_in_masterinterfaces:in master_adress;
request_in_masterinterfaces:in master_slave;


data_toM_masterinterfaces:out master_slave_data; 
adress_toM_masterinterfaces:out master_slave_adress;
read_data_responsetoM_masterinterfaces:out master_slave;

request_toS_slaveinterfaces:out slave_master;						
adress_toS_slaveinterfaces:out slave_master_adress;
data_toS_slaveinterfaces:out slave_master_data;
RW_toS_slaveinterfaces:out slave_master;

data_fromS_slaveinterfaces:in  slave_master_data




);

end P2P_interconnect ;



architecture test of P2P_interconnect is



component manymasters_interface is

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



end component;




component manyslaves_interface 

port(

clk,reset: in std_logic;
request_fromMI: in slave_master ;							
adress_fromMI: in slave_master_adress;
data_fromMI: in slave_master_data;
RW_fromMI: in slave_master;
	
request_toS: out slave_master;						
adress_toS: out slave_master_adress;
data_toS: out slave_master_data;
RW_toS:out slave_master;

data_fromS: in slave_master_data;

data_toMI: out slave_master_data;
adress_toMI: out slave_master_adress;
data_response_toMI: out slave_master
										

);

end component;








----------------------------SIGNALS SIGNALS SIGNALS SIGNALS-------------------------


-----master interface signals



signal data_out_masterinterfaces: master_slave_data ; 					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
signal RW_out_masterinterfaces:master_slave; -- read = 1 , write = 0			-- type of request
signal adress_out_masterinterfaces: master_slave_adress;
signal request_out_masterinterfaces: master_slave;


signal data_fromSI_masterinterfaces: master_slave_data; 
signal adress_fromSI_masterinterfaces:master_slave_adress;
signal read_data_responsefromSI_masterinterfaces: master_slave ;	



-----many slaves interfaces

signal request_fromMI_slaveinterfaces: slave_master ;							
signal adress_fromMI_slaveinterfaces: slave_master_adress;
signal data_fromMI_slaveinterfaces: slave_master_data;
signal RW_fromMI_slaveinterfaces: slave_master;
	

signal data_toMI_slaveinterfaces: slave_master_data;
signal adress_toMI_slaveinterfaces: slave_master_adress;
signal data_response_toMI_slaveinterfaces: slave_master;
	

------- many slaves



begin



interface: manymasters_interface port map
 (
	
	data_in=>data_in_masterinterfaces,
	RW_in => RW_in_masterinterfaces,
	adress_in => adress_in_masterinterfaces,
	request_in => request_in_masterinterfaces,


	data_out => data_out_masterinterfaces,
	RW_out => RW_out_masterinterfaces,
	adress_out =>adress_out_masterinterfaces,
	request_out => request_out_masterinterfaces,

	data_fromSI =>data_fromSI_masterinterfaces,
	adress_fromSI =>adress_fromSI_masterinterfaces,
	read_data_responsefromSI =>read_data_responsefromSI_masterinterfaces ,

	data_toM =>data_toM_masterinterfaces ,
	adress_toM =>adress_toM_masterinterfaces,
	read_data_responsetoM =>read_data_responsetoM_masterinterfaces


 );





	
slaves_interfaces:manyslaves_interface port map (

clk => clk,			
reset => reset,

request_fromMI =>request_fromMI_slaveinterfaces	,	
adress_fromMI =>adress_fromMI_slaveinterfaces,
data_fromMI =>data_fromMI_slaveinterfaces,
RW_fromMI =>RW_fromMI_slaveinterfaces,
							
adress_toS =>adress_toS_slaveinterfaces,
request_toS =>request_toS_slaveinterfaces,
data_toS =>data_toS_slaveinterfaces,
RW_toS =>RW_toS_slaveinterfaces,

data_fromS =>data_fromS_slaveinterfaces,

data_toMI =>data_toMI_slaveinterfaces,
adress_toMI =>adress_toMI_slaveinterfaces,
data_response_toMI =>data_response_toMI_slaveinterfaces
							

);



--------HERE STARTS THE LOGIC----------------------------------------------------------------------------------







			










process(data_out_masterinterfaces,RW_out_masterinterfaces,adress_out_masterinterfaces,request_out_masterinterfaces,data_toMI_slaveinterfaces,adress_toMI_slaveinterfaces,data_response_toMI_slaveinterfaces)
begin


for i in 0 to number_of_masters-1 loop
	for j in 0 to number_of_slaves-1 loop
		
		data_fromMI_slaveinterfaces(j)(i)<= data_out_masterinterfaces(i)(j);
		RW_fromMI_slaveinterfaces(j)(i)<= RW_out_masterinterfaces(i)(j);
		adress_fromMI_slaveinterfaces(j)(i)<= adress_out_masterinterfaces(i)(j);
		request_fromMI_slaveinterfaces(j)(i)	<= request_out_masterinterfaces(i)(j);

		data_fromSI_masterinterfaces(i)(j)<=data_toMI_slaveinterfaces(j)(i);
		adress_fromSI_masterinterfaces(i)(j)<=adress_toMI_slaveinterfaces(j)(i);
		read_data_responsefromSI_masterinterfaces(i)(j) <=data_response_toMI_slaveinterfaces(j)(i);

	end loop;
end loop;


end process;



end test;
