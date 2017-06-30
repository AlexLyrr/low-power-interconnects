library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.DEMO_PACK.all;
use std.textio.all;
--use work.CONV_PACK_crossbar_interconnect.all;

entity master is 

generic(
	file1: string :="C:\Users\Alex\Desktop\inputs\input.data0.txt";		-- files for inputs/destinations/time/ReadOrWriteBit/ReadInputs/WriteOutputs
	file2: string :="C:\Users\Alex\Desktop\destis\desti.data0.txt";
	file3: string :="C:\Users\Alex\Desktop\time\time.data0.txt";
	file4: string :="C:\Users\Alex\Desktop\read_write\read_write.data0.txt";

	file5:string :="C:\Users\Alex\Desktop\adress\adress.data0.txt";

	
	file6: string  := "C:\Users\Alex\Desktop\outputs\output.data0.txt"
	

                    );


port (
	clk, reset: in std_logic;
	
	
	-- data inputs and outputs
	
	-- request write/read ports

									--then the master noticed it throught this variable

data_out: out std_logic_vector (data_width downto 1) ; 	
request_out: out slave_size ;					-- (number of slaves) bits .for example,If we have 5 components then the master requests 1st and 2nd component by setting request_master=00011
RW_out:out std_logic ; -- read = 1 , write = 0			-- type of request
adress_out: out adress_size;

	-- read request response


Read_response: in std_logic ;					-- if a slave send data back to the master(respond to a data request) then read_response is set to '1'
data_in: in std_logic_vector (data_width-1 downto 0);
adress_in: in adress_size;

busy: in std_logic


);

end master;

architecture a2 of master is

file stimulus1: TEXT open read_mode is file1;
file stimulus2: TEXT open read_mode is file2;
file stimulus3: TEXT open read_mode is file3;
file stimulus4: TEXT open read_mode is file4;
file stimulus5: TEXT open read_mode is file5;


file stimulus6: TEXT open write_mode is file6;



--signal Read_request: std_logic := '0'; -- set to 1 if a read_request start and set to 0 if it is responded in order to move on to the next request.

signal data_help: std_logic_vector (data_width-1 downto 0) ;	
signal RW_help:std_logic;
signal adress_help:std_logic_vector (adress_width-1 downto 0) ;
signal request_help:std_logic_vector (number_of_slaves-1 downto 0);

signal waiting_time: unsigned(44 downto 1) := (others => '0');
signal counter: unsigned(44 downto 1) :=(others => '0');


begin



-- RECEIVE DATA PROCESS ,when master is a receiving a read request response.





receive_data: process(clk)		

variable l: line;
   
begin                                       


	if (clk'event and clk='1') then
	
			if Read_response = '1' then
				print(stimulus6,str(data_in));	-- write data to memory
			end if;
	end if;

end process receive_data;


--WRITE/READ REQUEST PROCESS 


aram2:process

variable l: line;
variable s1: string(data_width downto 1);
variable s2: string(number_of_slaves downto 1);
variable s3: string(15 downto 1);
variable s4: character;
variable s5: string(adress_width downto 1);


begin
	
wait until reset ='0';

data_help <= (others => '0');
request_help <= (others => '0');
RW_help <= '0';
adress_help <= (others => '0');
wait for 0.1 ns;
data_out<= data_help;
request_out<= request_help;
RW_out<= RW_help;
adress_out<= adress_help;
wait until reset='1';
loop
wait until (clk'event and clk='1');
counter <= counter+1;	--measure the clock cycles.
	if busy ='0' then
		if (counter > waiting_time or counter = waiting_time) then
		
			if (not endfile(stimulus1)) or ( not endfile(stimulus2)) or (not endfile(stimulus3)) or (not endfile(stimulus4)) or (not endfile(stimulus5)) then

				readline(stimulus1, l);
				read(l, s1);
				data_help  <= to_std_logic_vector(s1); -- read data from a file


				readline(stimulus2, l);
				read(l, s2);
				request_help <= to_std_logic_vector(s2);	-- read from a file which components will requests
				
				readline(stimulus3, l);
				read(l, s3);
				waiting_time <= decimal_string_to_unsigned(s3,44);		-- read from a file the waiting time before move on to the next request
				
				readline(stimulus4, l);				-- read from a file the type of the request from a file
				read(l, s4);
				RW_help <= to_std_logic(s4);		

				readline(stimulus5, l);				-- read from a file the type of the request from a file
				read(l, s5);
				adress_help <= to_std_logic_vector(s5);
				
				wait for 1 ns;
				if request_help /= (number_of_slaves-1 downto 0 =>'0') then
					data_out<= data_help;
					request_out<= request_help;
					RW_out<= RW_help;
					adress_out<= adress_help;
				else
					data_out <= (others => '0');
					RW_out <= '0';
					adress_out <= (others => '0');
				end if;
				
		
	
			end if;
		else
		request_help<= (others =>'0');
		data_help<= (others =>'0');
		RW_help<= '0';
		adress_help<= (others =>'0');
		wait for 1 ns;
		data_out<= data_help;
		request_out<= request_help;
		RW_out<= RW_help;
		adress_out<= adress_help;
		end if;

	
	end if;
	



end loop;

end process aram2;

end a2;






