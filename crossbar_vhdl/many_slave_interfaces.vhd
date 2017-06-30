library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity manyslaves_interface is

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



end manyslaves_interface;


architecture a3 of manyslaves_interface is


component slave_interface

port (

clk, reset: in std_logic;
						
adress_fromMF: in std_logic_vector (adress_width-1 downto 0);
data_fromMF: in std_logic_vector (data_width-1 downto 0);
RW_fromMF: in std_logic;
			
adress_toS: out std_logic_vector (adress_width-1 downto 0);
request_toS: out std_logic;
data_toS: out std_logic_vector (data_width-1 downto 0);
RW_toS:out std_logic;

data_fromS: in std_logic_vector (data_width-1 downto 0);

data_toSF: out std_logic_vector (data_width-1 downto 0);
adress_toSF: out std_logic_vector (adress_width-1 downto 0);

grant_fromAS : in std_logic_vector(number_of_masters-1 downto 0);

RW_toAS: out std_logic		

);


end component;




begin


arrayi: for i in number_of_slaves-1 downto 0 generate

		sw: slave_interface
		port map(
			clk => clk,
			reset => reset,
			
					
			adress_fromMF =>adress_fromMF(i),
			data_fromMF =>data_fromMF(i),
			RW_fromMF =>RW_fromMF(i),
							
			adress_toS =>adress_toS(i),
			request_toS =>request_toS(i),
			data_toS =>data_toS(i),
			RW_toS =>RW_toS(i),

			data_fromS =>data_fromS(i),

			data_toSF =>data_toSF(i),
			adress_toSF =>adress_toSF(i),

			grant_fromAS => grant_fromAS(i),
			
			RW_toAS=> RW_toAS(i)

			);
		
		end generate arrayi;




end a3;















