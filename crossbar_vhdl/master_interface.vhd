library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity master_interface is 


port (
	clk, reset: in std_logic;
	
	
	-- data inputs and outputs
	
	-- request write/read ports


data_in: in std_logic_vector (data_width-1 downto 0) ; 		-- The inputs from a master				
RW_in:in std_logic ; -- read = 1 , write = 0			-- type of request. We have 2 types of requests, read and write. For a read request RW='1'.
adress_in: in std_logic_vector (adress_width-1 downto 0);
request_in: in std_logic_vector(number_of_slaves-1 downto 0);
							

data_out: out std_logic_vector (data_width-1 downto 0) ; 	-- The outputs of the master interface
RW_out:out std_logic ; -- read = 1 , write = 0			
adress_out: out std_logic_vector (adress_width-1 downto 0);	

request_to_arbiter: out std_logic_vector(number_of_slaves-1 downto 0);	-- The slaves that the master interface is requesting from the arbiter.



grant_from_arbiter: in std_logic_vector(number_of_slaves-1 downto 0);	-- The grants that the master interface receives from the arbiter
busy_toM:out std_logic;							-- informs the master if he is available or not.


data_fromSF: in std_logic_vector (data_width-1 downto 0) ; 		-- Data and address ports for the response.
adress_fromSF:in std_logic_vector (adress_width-1 downto 0);
read_data_responsefromSF:in std_logic_vector(number_of_slaves-1 downto 0);	-- If a slave delivers a response then the corresponding bit is set to '1'. 


data_toM: out std_logic_vector (data_width-1 downto 0) ; 		-- Deliver responses to the master
adress_toM:out std_logic_vector (adress_width-1 downto 0);
read_data_responsetoM: out std_logic					-- informs the master about an upcoming response
-----------

);

end master_interface;

architecture a2 of master_interface is

component OR_gate_gen

  GENERIC (n : INTEGER);

  port   ( 
		A: in std_logic_vector(n-1 downto 0);
		C: out std_logic

	 );

end component;

component mux_2to1_top is
    Port ( SEL : in  STD_LOGIC;
           A   : in  std_logic_vector(number_of_slaves-1 downto 0);
           B   : in  std_logic_vector(number_of_slaves-1 downto 0);
           X   : out std_logic_vector(number_of_slaves-1 downto 0)
	);
end component;


signal request_stored: std_logic_vector(number_of_slaves-1 downto 0); 
signal enable:std_logic;

signal busy_help: std_logic;
signal request_stored2: std_logic_vector(number_of_slaves-1 downto 0);

begin

aw:OR_gate_gen
generic map(

n => number_of_slaves
)
port map(

A => read_data_responsefromSF,
C => read_data_responsetoM
);

bw:mux_2to1_top
port map(

SEL => busy_help,
A => request_in,
B  => request_stored2,
X  => request_to_arbiter
);

-----response to master

request_stored2 <= request_stored and (not grant_from_arbiter);
busy_help <= not enable;

busy_toM <= not enable;
data_toM<=data_fromSF;
adress_toM<=adress_fromSF;


enable <= '1' when grant_from_arbiter=request_stored else '0' ;  -- If the master interface received permission for every slave that he requested then the master interface is available 
								-- and can move on to the next master request.


ReqArbiter:process(clk,reset)

begin
if reset ='0' then				
	request_stored<= (others =>'0');
	data_out <= (others => '0');
	RW_out <= '0';
	adress_out <= (others => '0');
else
if (clk'event and clk='1')  then	
	if enable='1' then			-- if the master interface is granted with permission then move on to the next request
		request_stored<= request_in;
		data_out <= data_in;	
		adress_out <= adress_in;	
		RW_out <= RW_in;
	else					-- if not then mask out any of the desired slaves that may have been served and keep the requested slaves that still pend.
		request_stored <= request_stored and (not grant_from_arbiter);
	end if;
end if;
end if;
end process ReqArbiter;



end a2;






