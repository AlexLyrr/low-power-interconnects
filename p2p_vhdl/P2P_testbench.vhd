library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.DEMO_PACK.all;

--use work.CONV_PACK_P2P_interconnect.all;


entity P2P_tb is

end P2P_tb ;



architecture test of P2P_tb is

component manymasters

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



end component;

component P2P_interconnect

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

end component ;


component manyslaves

port(

clk, reset: in std_logic;

data_out: out slave_master_data ;	


RW_in: in slave_master;
request_in: in slave_master;
data_in: in slave_master_data;
adress_in: in slave_master_adress

);


end component;






----------------------------SIGNALS SIGNALS SIGNALS SIGNALS-------------------------
-----global signals

signal global_clk,global_reset: std_logic ;


-----master signals

signal data_out_manymasters: master_data;
signal request_out_manymasters: master_slave;
signal RW_out_manymasters: std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0

signal adress_out_manymasters: master_adress;

signal Read_response_manymasters: master_slave;		-- if a slave send data back to the master(respond to a data request) then read_response is set to '1'
signal data_in_manymasters: master_slave_data;
signal adress_in_manymasters: master_slave_adress;

-----master interface signals


signal data_in_masterinterfaces: master_data;
signal RW_in_masterinterfaces:std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
signal adress_in_masterinterfaces: master_adress;
signal request_in_masterinterfaces: master_slave;


signal data_out_masterinterfaces: master_slave_data ; 					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
signal RW_out_masterinterfaces:master_slave; -- read = 1 , write = 0			-- type of request
signal adress_out_masterinterfaces: master_slave_adress;
signal request_out_masterinterfaces: master_slave;


signal data_fromSF_masterinterfaces: master_slave_data; 
signal adress_fromSF_masterinterfaces:master_slave_adress;
signal read_data_responsefromSF_masterinterfaces: master_slave ;	

signal data_toM_masterinterfaces: master_slave_data; 
signal adress_toM_masterinterfaces: master_slave_adress;
signal read_data_responsetoM_masterinterfaces: master_slave;


-----many slaves interfaces

signal request_fromMF_slaveinterfaces: slave_master ;							
signal adress_fromMF_slaveinterfaces: slave_master_adress;
signal data_fromMF_slaveinterfaces: slave_master_data;
signal RW_fromMF_slaveinterfaces: slave_master;
	
signal request_toS_slaveinterfaces: slave_master;						
signal adress_toS_slaveinterfaces: slave_master_adress;
signal data_toS_slaveinterfaces: slave_master_data;
signal RW_toS_slaveinterfaces: slave_master;

signal data_fromS_slaveinterfaces:  slave_master_data;

signal data_toSF_slaveinterfaces: slave_master_data;
signal adress_toSF_slaveinterfaces: slave_master_adress;
signal data_response_toSF_slaveinterfaces: slave_master;
	

------- many slaves

signal data_out_manyslaves: slave_master_data ;	


signal RW_in_manyslaves: slave_master;
signal request_in_manyslaves: slave_master;
signal data_in_manyslaves: slave_master_data;
signal adress_in_manyslaves: slave_master_adress;




signal counter: integer := 0;



begin

Masters: manymasters port map (
					clk => global_clk,
					reset => global_reset,

					data_out => data_out_manymasters,
					request_out => request_out_manymasters,
					RW_out => RW_out_manymasters,
					adress_out =>adress_out_manymasters,
					
					read_response => read_response_manymasters,
					data_in => data_in_manymasters,
					adress_in => adress_in_manymasters
				
				
					);



p2p: P2P_interconnect port map
 (
	
	clk => global_clk,
	reset => global_reset,

	data_in_masterinterfaces =>data_in_masterinterfaces,
	RW_in_masterinterfaces =>RW_in_masterinterfaces,
	adress_in_masterinterfaces =>adress_in_masterinterfaces,
	request_in_masterinterfaces =>request_in_masterinterfaces ,


	data_toM_masterinterfaces =>data_toM_masterinterfaces,
	adress_toM_masterinterfaces =>adress_toM_masterinterfaces,
	read_data_responsetoM_masterinterfaces =>read_data_responsetoM_masterinterfaces,

	request_toS_slaveinterfaces =>	request_toS_slaveinterfaces	,			
	adress_toS_slaveinterfaces =>adress_toS_slaveinterfaces,
	data_toS_slaveinterfaces =>data_toS_slaveinterfaces,
	RW_toS_slaveinterfaces =>RW_toS_slaveinterfaces,

	data_fromS_slaveinterfaces =>data_fromS_slaveinterfaces

 );




slaves: manyslaves port map(

			clk => global_clk,
			reset => global_reset,

			data_out => data_out_manyslaves,
			
			RW_in => RW_in_manyslaves,
			request_in => request_in_manyslaves,
			data_in =>data_in_manyslaves,
			adress_in => adress_in_manyslaves


);


--------HERE STARTS THE LOGIC----------------------------------------------------------------------------------


data_in_masterinterfaces<= data_out_manymasters;
request_in_masterinterfaces<= request_out_manymasters;
RW_in_masterinterfaces<= RW_out_manymasters;
adress_in_masterinterfaces<= adress_out_manymasters;
					
read_response_manymasters<=read_data_responsetoM_masterinterfaces;
data_in_manymasters<=data_toM_masterinterfaces ;
adress_in_manymasters<=adress_toM_masterinterfaces;






						
adress_in_manyslaves<= adress_toS_slaveinterfaces;
request_in_manyslaves<= request_toS_slaveinterfaces;
data_in_manyslaves<= data_toS_slaveinterfaces;
RW_in_manyslaves<= RW_toS_slaveinterfaces;

data_fromS_slaveinterfaces<= data_out_manyslaves;



			










process(data_out_masterinterfaces,RW_out_masterinterfaces,adress_out_masterinterfaces,request_out_masterinterfaces,data_toSF_slaveinterfaces,adress_toSF_slaveinterfaces,data_response_toSF_slaveinterfaces)
begin


for i in 0 to number_of_masters-1 loop
	for j in 0 to number_of_slaves-1 loop
		
		data_fromMF_slaveinterfaces(j)(i)<= data_out_masterinterfaces(i)(j);
		RW_fromMF_slaveinterfaces(j)(i)<= RW_out_masterinterfaces(i)(j);
		adress_fromMF_slaveinterfaces(j)(i)<= adress_out_masterinterfaces(i)(j);
		request_fromMF_slaveinterfaces(j)(i)	<= request_out_masterinterfaces(i)(j);

		data_fromSF_masterinterfaces(i)(j)<=data_toSF_slaveinterfaces(j)(i);
		adress_fromSF_masterinterfaces(i)(j)<=adress_toSF_slaveinterfaces(j)(i);
		read_data_responsefromSF_masterinterfaces(i)(j) <=data_response_toSF_slaveinterfaces(j)(i);

	end loop;
end loop;


end process;

reset_arbiter: Process
begin
global_reset <= '0';
wait for 32000 ps;
global_reset <= '1';
wait;
end process;

clk1_generator: PROCESS
begin
global_clk <= '1';
WAIT FOR 25000 ps;
global_clk <= '0';
WAIT FOR 25000 ps;
counter <= counter+1 ;
END PROCESS;	


end test;
