library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity master_interface is 


port (
	
	

data_in: in std_logic_vector (data_width downto 1) ; 					
RW_in:in std_logic ; -- read = 1 , write = 0			
adress_in: in adress_size;
request_in: in slave_size;
							

data_out: out slave_data ; 					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
RW_out:out std_logic_vector(number_of_slaves-1 downto 0) ; -- read = 1 , write = 0			-- type of request
adress_out: out slave_adress;
request_out: out slave_size;


-----FROM SLAVE FABRIC TO MASTER

data_fromSI: in slave_data; 
adress_fromSI:in slave_adress;
read_data_responsefromSI:in std_logic_vector (number_of_slaves-1 downto 0) ;	

data_toM: out slave_data; 
adress_toM:out slave_adress;
read_data_responsetoM: out std_logic_vector (number_of_slaves-1 downto 0) 	
-----------



);

end master_interface;

architecture a2 of master_interface is

begin

request_out <= request_in;		-- response

data_toM <=data_fromSI;
adress_toM <=adress_fromSI;
read_data_responsetoM <= read_data_responsefromSI;

buffs:process(request_in,data_in,RW_in,adress_in)



begin
	
for i in 0 to number_of_slaves-1 loop		-- request
	if request_in(i) = '1' then
		data_out(i) <= data_in;
		adress_out(i) <= adress_in;
		RW_out(i) <= RW_in;
	else
		data_out(i)<= (others => '0');
		adress_out(i) <= (others => '0');
		RW_out(i) <= '0';
	end if;
end loop;


end process buffs;

end a2;






