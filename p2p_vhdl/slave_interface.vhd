library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity slave_interface is 


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

end slave_interface;

architecture a2 of slave_interface is

signal adress_help: adress_size;


begin

----------------Here starts the logic------------
data_toMI <= data_fromS;
	
data_toS<= data_fromMI;		
adress_toS<= adress_fromMI;
RW_toS<= RW_fromMI;
request_toS <= request_fromMI;


buffs:process (clk,reset)

begin
	
if reset ='0' then
	for i in 0 to number_of_masters-1 loop
		adress_toMI(i) <= (others => '0');
	end loop;
	data_response_toMI  <= (others => '0');
	
else

if (clk'event and clk='1') then
	data_response_toMI<= RW_fromMI;
	for i in 0 to number_of_masters-1 loop
		if RW_fromMI(i)='1' then
			adress_toMI(i) <= adress_fromMI(i);
		end if;
	end loop;


end if; -- for the reset function

end if;
end process buffs;

end a2;






