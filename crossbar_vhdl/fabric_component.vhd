library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;


Entity fabric_component is

  port   ( 
		data_in: in master_data;
		RW_in: in std_logic_vector(number_of_masters-1 downto 0);
		adress_in: in master_adress;

		data_out: out std_logic_vector (data_width-1 downto 0);
		RW_out: out std_logic;
		adress_out: out std_logic_vector (adress_width-1 downto 0);

		cntrl1 : in std_logic_vector(number_of_masters-1 downto 0)
		


	 );
end fabric_component;

Architecture a1 of fabric_component is

signal data_RESULT: master_data ;
signal adress_RESULT: master_adress;
signal RW_RESULT:std_logic_vector(number_of_masters-1 downto 0);


begin


data_out<= data_RESULT(number_of_masters-1);
adress_out<= adress_RESULT(number_of_masters-1);
RW_out <= RW_RESULT(number_of_masters-1);



process(cntrl1,data_in,RW_in,adress_in,data_RESULT,adress_RESULT,RW_RESULT)
begin


for j in 0 to data_width-1 loop
	data_RESULT(0)(j) <= (data_in(0)(j) AND cntrl1(0));
	for i in 1 to number_of_masters-1 loop
		data_RESULT(i)(j) <= data_RESULT(i-1)(j) OR (data_in(i)(j) AND cntrl1(i));
	end loop;
end loop;

for j in 0 to adress_width-1 loop
	adress_RESULT(0)(j) <= (adress_in(0)(j) AND cntrl1(0));
	for i in 1 to number_of_masters-1 loop
		adress_RESULT(i)(j) <= adress_RESULT(i-1)(j) OR (adress_in(i)(j) AND cntrl1(i));
	end loop;
end loop;


RW_RESULT(0) <= (RW_in(0) AND cntrl1(0));
for i in 1 to number_of_masters-1 loop
	RW_RESULT(i) <= RW_RESULT(i-1) OR (RW_in(i) AND cntrl1(i));
end loop;



end process;
end a1;