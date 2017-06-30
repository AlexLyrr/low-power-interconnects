library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.DEMO_PACK.all;
--use work.CONV_PACK_crossbar_interconnect.all;

entity crossbar_tb is

end crossbar_tb ;



architecture test of crossbar_tb is


component manymasters

port(
clk, reset: in std_logic;

data_out: out master_data;
request_out: out master_slave;
RW_out:out std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0

adress_out: out master_adress;


read_response: in std_logic_vector(number_of_masters-1 downto 0);
data_in: in master_data;
adress_in: in master_adress;


busy: in std_logic_vector(number_of_masters-1 downto 0)


);

end component;



component manyslaves

port(

clk, reset: in std_logic;

data_out: out slave_data;

RW_in: in std_logic_vector(number_of_slaves-1 downto 0) ;
request_in: in slave_size;
data_in: in slave_data;
adress_in: in slave_adress


);
end component;


component crossbar_interconnect

port
(

clk,reset:in std_logic ;

--MASTER SIDE

 data_in_masterinterfaces:in master_data;
 RW_in_masterinterfaces:in std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
 adress_in_masterinterfaces:in master_adress;
 request_in_masterinterfaces:in master_slave;

 busy_toM_masterinterfaces:out std_logic_vector(number_of_masters-1 downto 0);
 data_toM_masterinterfaces:out master_data; 
 adress_toM_masterinterfaces:out master_adress;
 read_data_responsetoM_masterinterfaces:out std_logic_vector(number_of_masters-1 downto 0);


--SLAVE SIDE
 request_toS_slaveinterfaces:out std_logic_vector(number_of_slaves-1 downto 0);						
 adress_toS_slaveinterfaces:out slave_adress;
 data_toS_slaveinterfaces:out slave_data;
 RW_toS_slaveinterfaces:out std_logic_vector(number_of_slaves-1 downto 0);

 data_fromS_slaveinterfaces:in slave_data



);

end component ;



----------------------------SIGNALS SIGNALS SIGNALS SIGNALS-------------------------
-----global signals

signal global_clk,global_reset: std_logic ;


-----master signals


signal data_out_manymasters: master_data;
signal request_out_manymasters: master_slave;
signal RW_out_manymasters:std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
signal adress_out_manymasters:master_adress;


signal read_response_manymasters: std_logic_vector(number_of_masters-1 downto 0);
signal data_in_manymasters: master_data;
signal adress_in_manymasters: master_adress;


signal busy_manymasters:std_logic_vector(number_of_masters-1 downto 0);

-----master interface signals

signal data_in_masterinterfaces: master_data;
signal RW_in_masterinterfaces: std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
signal adress_in_masterinterfaces: master_adress;
signal request_in_masterinterfaces: master_slave;


signal busy_toM_masterinterfaces:std_logic_vector(number_of_masters-1 downto 0);


signal data_toM_masterinterfaces: master_data; 
signal adress_toM_masterinterfaces: master_adress;
signal read_data_responsetoM_masterinterfaces: std_logic_vector(number_of_masters-1 downto 0);



-----many slaves


signal data_out_Manyslaves: slave_data;

signal RW_in_Manyslaves: std_logic_vector(number_of_slaves-1 downto 0) ;
signal request_in_Manyslaves: slave_size;
signal data_in_Manyslaves: slave_data;
signal adress_in_Manyslaves: slave_adress;


------- many slave interfaces

signal request_toS_slaveinterfaces: std_logic_vector (number_of_slaves-1 downto 0);						
signal adress_toS_slaveinterfaces: slave_adress;
signal data_toS_slaveinterfaces: slave_data;
signal RW_toS_slaveinterfaces:std_logic_vector (number_of_slaves-1 downto 0);

signal data_fromS_slaveinterfaces: slave_data;


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
					adress_in => adress_in_manymasters,

					busy =>busy_manymasters


					
					
				
					);



interconnect: crossbar_interconnect port map(

clk => global_clk,
reset => global_reset,


--MASTER SIDE

data_in_masterinterfaces => data_in_masterinterfaces,
RW_in_masterinterfaces =>RW_in_masterinterfaces,
adress_in_masterinterfaces =>adress_in_masterinterfaces,
request_in_masterinterfaces =>request_in_masterinterfaces,

busy_toM_masterinterfaces =>busy_toM_masterinterfaces,
data_toM_masterinterfaces =>data_toM_masterinterfaces,
adress_toM_masterinterfaces =>adress_toM_masterinterfaces,
read_data_responsetoM_masterinterfaces =>read_data_responsetoM_masterinterfaces,


--SLAVE SIDE
request_toS_slaveinterfaces =>	request_toS_slaveinterfaces,				
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


-----many masters
data_in_masterinterfaces<= data_out_manymasters;
RW_in_masterinterfaces<= RW_out_manymasters;
adress_in_masterinterfaces<= adress_out_manymasters;
request_in_masterinterfaces<=request_out_manymasters;


busy_manymasters<= busy_toM_masterinterfaces;


data_in_manymasters<= data_toM_masterinterfaces;
adress_in_manymasters<= adress_toM_masterinterfaces;
read_response_manymasters<= read_data_responsetoM_masterinterfaces;


---many slaves
	
request_in_Manyslaves<= request_toS_slaveinterfaces;					
adress_in_Manyslaves<= adress_toS_slaveinterfaces;
data_in_Manyslaves<= data_toS_slaveinterfaces;
RW_in_Manyslaves<= RW_toS_slaveinterfaces;

data_fromS_slaveinterfaces <= data_out_manyslaves;



reset_arbiter: Process
begin
global_reset <= '0';
wait for 30000 ps;
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
