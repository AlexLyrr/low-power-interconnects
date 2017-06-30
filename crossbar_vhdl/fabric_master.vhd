library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity master_fabric is 

port (

data_in: in master_data;
RW_in: in std_logic_vector(number_of_masters-1 downto 0);
adress_in: in master_adress;

data_out: out slave_data;
RW_out: out std_logic_vector(number_of_slaves-1 downto 0);
adress_out: out slave_adress;

cntrl1_fabric : in slave_master

);

end master_fabric;



architecture a1 of master_fabric is 


component fabric_component

  port   ( 
		
		data_in: in master_data;
		RW_in: in std_logic_vector(number_of_masters-1 downto 0);
		adress_in: in master_adress;

		data_out: out std_logic_vector (data_width-1 downto 0);
		RW_out: out std_logic;
		adress_out: out std_logic_vector (adress_width-1 downto 0);

		cntrl1: in std_logic_vector(number_of_masters-1 downto 0)
	 );
end component;




begin


arrayj: for j in number_of_slaves-1 downto 0 generate
		
		aw:fabric_component
		port map(

			data_in => data_in,
			RW_in => RW_in,
			adress_in => adress_in,

			data_out =>data_out(j),
			RW_out =>RW_out(j),
			adress_out => adress_out(j),
	
			cntrl1=> cntrl1_fabric(j)
			);
end generate arrayj;

			









end a1;





