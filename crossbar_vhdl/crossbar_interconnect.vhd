library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;
--use work.CONV_PACK_crossbar_interconnect.all;


entity crossbar_interconnect is

port(

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

end crossbar_interconnect ;



architecture test of crossbar_interconnect is


component manymasters_interface is

port(

clk, reset: in std_logic;

data_in: in master_data;
RW_in:in std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
adress_in: in master_adress;
request_in: in master_slave;

data_out: out master_data;
RW_out:out std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
adress_out: out master_adress;

request_to_arbiter: out master_slave;

busy_toM:out std_logic_vector(number_of_masters-1 downto 0);
grant_from_arbiter: in master_slave;


data_fromSF: in master_data; 
adress_fromSF:in master_adress;
read_data_responsefromSF:in master_slave;

data_toM: out master_data; 
adress_toM:out  master_adress;
read_data_responsetoM: out std_logic_vector(number_of_masters-1 downto 0)




);



end component;



component crossbar_arbiter is 


port (

		clk   : in    std_logic;
		reset : in    std_logic;
		req_arbiter   : in    slave_master;
		grant_arbiter : out   slave_master
	
);

end component;

component master_fabric is 

port (


data_in: in master_data;
RW_in: in std_logic_vector(number_of_masters-1 downto 0);
adress_in: in master_adress;

data_out: out slave_data;
RW_out: out std_logic_vector(number_of_slaves-1 downto 0);
adress_out: out slave_adress;

cntrl1_fabric : in slave_master 

);


end component;





component manyslaves_interface 

port(

clk, reset: in std_logic;
	
						
adress_fromMF: in slave_adress;
data_fromMF: in slave_data;
RW_fromMF: in std_logic_vector(number_of_slaves-1 downto 0);
							
adress_toS: out slave_adress;
request_toS: out std_logic_vector(number_of_slaves-1 downto 0);
data_toS: out slave_data;
RW_toS:out std_logic_vector(number_of_slaves-1 downto 0);

data_fromS: in slave_data;

data_toSF: out slave_data;
adress_toSF: out slave_adress;

grant_fromAS : in slave_master;

RW_toAS: out std_logic_vector(number_of_slaves-1 downto 0)
);

end component;

component slave_fabric

port (


data_in: in slave_data;
adress_in: slave_adress;


data_out: out master_data ;
adress_out: out master_adress;

cntrl2_fabric : in master_slave 
);

end component;


component arbiter_slave is 


port (
	clk, reset: in std_logic;


grant_in : in  slave_master;
enable: in std_logic_vector(number_of_slaves-1 downto 0);

grant_out : out   master_slave

);

end component;









----------------------------SIGNALS SIGNALS SIGNALS SIGNALS-------------------------

-----master interface signals



signal data_out_masterinterfaces: master_data;
signal RW_out_masterinterfaces: std_logic_vector(number_of_masters-1 downto 0); -- read = 1 , write = 0
signal adress_out_masterinterfaces: master_adress;
signal request_out_masterinterfaces: master_slave;

signal request_to_arbiter_masterinterfaces: master_slave;


signal grant_from_arbiter_masterinterfaces: master_slave;
signal busy_toM_MIF:std_logic_vector(number_of_masters-1 downto 0);

signal data_fromSF_masterinterfaces: master_data; 
signal adress_fromSF_masterinterfaces: master_adress;
signal read_data_responsefromSF_masterinterfaces: master_slave;



----arbiter

signal req_arbiter   :    slave_master;
signal grant_arbiter :  slave_master;

----master fabric

signal data_in_MasterFabric: master_data;
signal RW_in_MasterFabric: std_logic_vector(number_of_masters-1 downto 0);
signal adress_in_MasterFabric: master_adress;

signal data_out_MasterFabric: slave_data;
signal RW_out_MasterFabric: std_logic_vector(number_of_slaves-1 downto 0);
signal adress_out_MasterFabric: slave_adress;

signal cntrl1_fabric_MasterFabric : slave_master ;




------- many slave interfaces


						
signal adress_fromMF_slaveinterfaces: slave_adress;
signal data_fromMF_slaveinterfaces: slave_data;
signal RW_fromMF_slaveinterfaces:std_logic_vector(number_of_slaves-1 downto 0);
	


signal data_toSF_slaveinterfaces: slave_data;
signal adress_toSF_slaveinterfaces:  slave_adress;
	
signal grant_fromAS_slaveinterfaces: slave_master;

signal RW_toAS_slaveinterfaces:std_logic_vector(number_of_slaves-1 downto 0);
	

------------arbiter slave


signal grant_in_arbiterSlave :  slave_master;
signal enable_arbiterSlave: std_logic_vector(number_of_slaves-1 downto 0);

signal grant_out_arbiterSlave :  master_slave;




-----------slave fabric



signal data_in_SlaveFabric: slave_data;
signal cntrl2_fabric_SlaveFabric : master_slave ;
signal adress_in_SlaveFabric:slave_adress;

signal data_out_SlaveFabric: master_data ;
signal adress_out_SlaveFabric:master_adress;


begin

master_interface: manymasters_interface port map
 (
	clk => clk,
	reset => reset,

	data_in=>data_in_masterinterfaces,
	RW_in => RW_in_masterinterfaces,
	adress_in => adress_in_masterinterfaces,
	request_in => request_in_masterinterfaces,


	data_out => data_out_masterinterfaces,
	RW_out => RW_out_masterinterfaces,
	adress_out =>adress_out_masterinterfaces,

	request_to_arbiter => request_to_arbiter_masterinterfaces,
	
	busy_toM=>busy_toM_MIF,
	grant_from_arbiter=>grant_from_arbiter_masterinterfaces,

	data_fromSF =>data_fromSF_masterinterfaces,
	adress_fromSF =>adress_fromSF_masterinterfaces,
	read_data_responsefromSF =>read_data_responsefromSF_masterinterfaces ,

	data_toM =>data_toM_masterinterfaces ,
	adress_toM =>adress_toM_masterinterfaces,
	read_data_responsetoM =>read_data_responsetoM_masterinterfaces


 );




MasterArbiter: crossbar_arbiter port map (
				clk => clk,
				reset => reset,
	
				req_arbiter  => req_arbiter,
				grant_arbiter => grant_arbiter
			);

MasterFabric: master_fabric port map(

			data_in => data_in_MasterFabric,
			RW_in => RW_in_MasterFabric,
			adress_in => adress_in_MasterFabric,

			data_out => data_out_MasterFabric,
			RW_out => RW_out_MasterFabric,
			adress_out => adress_out_MasterFabric,

			cntrl1_fabric => cntrl1_fabric_MasterFabric
);


	



slaves_interfaces:manyslaves_interface port map (

clk => clk,
reset => reset,

adress_fromMF =>adress_fromMF_slaveinterfaces,
data_fromMF =>data_fromMF_slaveinterfaces,
RW_fromMF =>RW_fromMF_slaveinterfaces,
							
adress_toS =>adress_toS_slaveinterfaces,
request_toS =>request_toS_slaveinterfaces,
data_toS =>data_toS_slaveinterfaces,
RW_toS =>RW_toS_slaveinterfaces,

data_fromS =>data_fromS_slaveinterfaces,

data_toSF =>data_toSF_slaveinterfaces,
adress_toSF =>adress_toSF_slaveinterfaces,
		
grant_fromAS=>grant_fromAS_slaveinterfaces,

RW_toAS=> RW_toAS_slaveinterfaces					

);


SlaveFabric:slave_fabric port map(


data_in =>data_in_SlaveFabric,
adress_in =>adress_in_SlaveFabric,

data_out =>data_out_SlaveFabric,
adress_out => adress_out_SlaveFabric,

cntrl2_fabric =>cntrl2_fabric_SlaveFabric


);

SlaveArbiter:arbiter_slave port map(


clk => clk,
reset => reset,

grant_in =>grant_in_arbiterSlave,
enable => enable_arbiterSlave,

grant_out =>grant_out_arbiterSlave

);










--------HERE STARTS THE LOGIC----------------------------------------------------------------------------------

-----master interfaces

data_fromSF_masterinterfaces <=data_out_SlaveFabric;
adress_fromSF_masterinterfaces <=adress_out_SlaveFabric;
read_data_responsefromSF_masterinterfaces <=grant_out_arbiterSlave;




----------MASTER FABRIC

data_in_MasterFabric <= data_out_masterinterfaces;
RW_in_MasterFabric <=RW_out_masterinterfaces;
adress_in_MasterFabric <= adress_out_masterinterfaces;

cntrl1_fabric_MasterFabric <= grant_arbiter;

-------------------------------- slaves interfaces

grant_fromAS_slaveinterfaces <=grant_arbiter;				
adress_fromMF_slaveinterfaces <=adress_out_MasterFabric;
data_fromMF_slaveinterfaces <=data_out_MasterFabric;
RW_fromMF_slaveinterfaces <=RW_out_MasterFabric;
	


data_in_SlaveFabric<= data_toSF_slaveinterfaces;
adress_in_SlaveFabric<= adress_toSF_slaveinterfaces;
					


------------------ ARBITER SLAVE
-------------------- SLAVE FABRIC

grant_in_arbiterSlave <= grant_arbiter;

enable_arbiterSlave <= RW_toAS_slaveinterfaces;

cntrl2_fabric_SlaveFabric <= grant_out_arbiterSlave;

busy_toM_masterinterfaces<= busy_toM_MIF;

process(request_to_arbiter_masterinterfaces,grant_arbiter)
begin


for i in 0 to number_of_masters-1 loop
	for j in 0 to number_of_slaves-1 loop
		req_arbiter(j)(i) <= request_to_arbiter_masterinterfaces(i)(j);
		grant_from_arbiter_masterinterfaces(i)(j)<=grant_arbiter(j)(i); 

		
		

	end loop;
end loop;


end process;


end test;
