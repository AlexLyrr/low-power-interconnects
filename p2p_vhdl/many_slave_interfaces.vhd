library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity manyslaves_interface is

port(

clk, reset: in std_logic;

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



end manyslaves_interface;


architecture a3 of manyslaves_interface is


component slave_interface

port (
	clk, reset: in std_logic;

request_fromMI: in master_size ;							
adress_fromMI: in master_adress;
data_fromMI: in master_data;
RW_fromMI: in std_logic_vector(number_of_masters-1 downto 0);
	
request_toS: out master_size;						
adress_toS: out master_adress;
data_toS: out master_data;
RW_toS:out std_logic_vector(number_of_masters-1 downto 0);

data_fromS: in master_data;

data_toMI: out master_data;
adress_toMI: out master_adress;
data_response_toMI: out std_logic_vector(number_of_masters-1 downto 0)
							

					

);


end component;




begin


arrayi: for i in number_of_slaves-1 downto 0 generate

		sw: slave_interface
		port map(
			reset => reset,
			clk => clk,
			
			
			request_fromMI =>request_fromMI(i),			
			adress_fromMI =>adress_fromMI(i),
			data_fromMI =>data_fromMI(i),
			RW_fromMI =>RW_fromMI(i),
							
			adress_toS =>adress_toS(i),
			request_toS =>request_toS(i),
			data_toS =>data_toS(i),
			RW_toS =>RW_toS(i),

			data_fromS =>data_fromS(i),

			data_toMI =>data_toMI(i),
			adress_toMI =>adress_toMI(i),
			data_response_toMI => data_response_toMI(i)


			);
		
		end generate arrayi;




end a3;















