library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity manymasters_interface is

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



end manymasters_interface;


architecture a3 of manymasters_interface is


component master_interface

port (
	clk, reset: in std_logic;
	

data_in: in std_logic_vector (data_width-1 downto 0) ; 						
RW_in:in std_logic ; -- read = 1 , write = 0			
adress_in: in std_logic_vector (adress_width-1 downto 0);
request_in: in std_logic_vector(number_of_slaves-1 downto 0);
							

data_out: out std_logic_vector (data_width-1 downto 0) ; 					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
RW_out:out std_logic ; -- read = 1 , write = 0			-- type of request
adress_out: out std_logic_vector (adress_width-1 downto 0);

request_to_arbiter: out std_logic_vector(number_of_slaves-1 downto 0);


------ arbiter results

grant_from_arbiter: in std_logic_vector(number_of_slaves-1 downto 0);
busy_toM:out std_logic;
-----FROM SLAVE FABRIC TO MASTER

data_fromSF: in std_logic_vector (data_width-1 downto 0) ; 
adress_fromSF:in std_logic_vector (adress_width-1 downto 0);
read_data_responsefromSF:in std_logic_vector(number_of_slaves-1 downto 0);


data_toM: out std_logic_vector (data_width-1 downto 0) ; 
adress_toM:out std_logic_vector (adress_width-1 downto 0);
read_data_responsetoM: out std_logic



);

end component;




begin


arrayi: for i in number_of_masters-1 downto 0 generate

		sw: master_interface
		port map(
			reset => reset,
			clk => clk,
			
			data_in => data_in(i),
			RW_in => RW_in(i),
			adress_in => adress_in(i),
			request_in => request_in(i),

			data_out => data_out(i),
			RW_out => RW_out(i),
			adress_out => adress_out(i),


			request_to_arbiter => request_to_arbiter(i),

			busy_toM => busy_toM(i),
			grant_from_arbiter=> grant_from_arbiter(i),
		
			data_fromSF => data_fromSF(i) ,
			adress_fromSF =>adress_fromSF(i),
			read_data_responsefromSF =>read_data_responsefromSF(i),

			data_toM =>data_toM(i),
			adress_toM =>adress_toM(i),
			read_data_responsetoM =>read_data_responsetoM(i)



			);
		
		end generate arrayi;




end a3;















