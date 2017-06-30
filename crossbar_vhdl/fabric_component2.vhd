library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

Entity fabric_component2 is

  port   ( 
		data_in: in slave_data;
		adress_in: in slave_adress;

		data_out: out std_logic_vector (data_width-1 downto 0);
		adress_out: out std_logic_vector (adress_width-1 downto 0);

		cntrl2 : in std_logic_vector(number_of_slaves-1 downto 0)
		


	 );
end fabric_component2;

Architecture a1 of fabric_component2 is


signal data_RESULT: slave_data ;
signal adress_RESULT: slave_adress;
signal RW_RESULT:std_logic_vector(number_of_slaves-1 downto 0);


begin

data_out<= data_RESULT(number_of_slaves-1);
adress_out<= adress_RESULT(number_of_slaves-1);



process(cntrl2,data_in,adress_in,data_RESULT,adress_RESULT)
begin


for j in 0 to data_width-1 loop
	data_RESULT(0)(j) <= (data_in(0)(j) AND cntrl2(0));
	for i in 1 to number_of_slaves-1 loop
		data_RESULT(i)(j) <= data_RESULT(i-1)(j) OR (data_in(i)(j) AND cntrl2(i));
	end loop;
end loop;

for j in 0 to adress_width-1 loop
	adress_RESULT(0)(j) <= (adress_in(0)(j) AND cntrl2(0));
	for i in 1 to number_of_slaves-1 loop
		adress_RESULT(i)(j) <= adress_RESULT(i-1)(j) OR (adress_in(i)(j) AND cntrl2(i));
	end loop;
end loop;


end process;

end a1;
