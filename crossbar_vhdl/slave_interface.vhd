library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity slave_interface is 


port (
	clk, reset: in std_logic;
	
						
adress_fromMF: in std_logic_vector (adress_width-1 downto 0);	-- data/address/request type from master fabric
data_fromMF: in std_logic_vector (data_width-1 downto 0);
RW_fromMF: in std_logic;
	
request_toS: out std_logic;					-- output ports to slave
adress_toS: out std_logic_vector (adress_width-1 downto 0);	
data_toS: out std_logic_vector (data_width-1 downto 0);
RW_toS:out std_logic;

data_fromS: in std_logic_vector (data_width-1 downto 0);	-- input data from slave

data_toSF: out std_logic_vector (data_width-1 downto 0);	-- ports to slave fabric 
adress_toSF: out std_logic_vector (adress_width-1 downto 0);
							
grant_fromAS : in std_logic_vector(number_of_masters-1 downto 0);	-- if any master delivers request to the slave

RW_toAS: out std_logic						-- notifies the arbiter about the type of request just received
);

end slave_interface;

architecture a2 of slave_interface is


component OR_gate_gen

  GENERIC (n : INTEGER);

  port   ( 
		A: in std_logic_vector(n-1 downto 0);
		C: out std_logic

	 );

end component;


signal adress_help: std_logic_vector (adress_width-1 downto 0);


begin

aw:OR_gate_gen
generic map(

n => number_of_masters
)
port map(

A => grant_fromAS,	-- if any master delivers request then notify the slave
C => request_toS 
);

adress_toS<=adress_fromMF;
data_toS<=data_fromMF;
RW_toS<=RW_fromMF;

data_toSF <= data_fromS;
			

adress_toSF<=adress_help;




buffs:process (clk,reset)

begin
	
if reset ='0' then

	adress_help <= (others => '0');
	
else

if (clk'event and clk='1') then
	RW_toAS<=RW_fromMF;	-- notify the arbiter about the type of request received
	if RW_fromMF='1' then
		adress_help <= adress_fromMF;
	end if;

end if; -- for the reset function

end if;
end process buffs;

end a2;


