library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity slave_fabric is 

port (


data_in: in slave_data;
adress_in: in slave_adress;


data_out: out master_data ;
adress_out: out master_adress;

cntrl2_fabric : in master_slave 

);

end slave_fabric;

architecture a1 of slave_fabric is 



component fabric_component2

  port   ( 
		
		data_in: in slave_data;
		adress_in: in slave_adress;

		data_out: out std_logic_vector (data_width-1 downto 0);
		adress_out: out std_logic_vector (adress_width-1 downto 0);

		cntrl2 : in std_logic_vector(number_of_slaves-1 downto 0)



	 );
end component;


begin

arrayi: for i in number_of_masters-1 downto 0 generate
		
		aw:fabric_component2
		port map(

			
			data_in => data_in,
			adress_in => adress_in,

			data_out =>data_out(i),
			adress_out => adress_out(i),
	
			cntrl2 => cntrl2_fabric(i)
			);


	       
end generate arrayi;






end a1;





