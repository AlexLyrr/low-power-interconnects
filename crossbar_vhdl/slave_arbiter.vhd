library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity arbiter_slave is 


port (


clk, reset: in std_logic;


grant_in : in  slave_master;
enable: in std_logic_vector(number_of_slaves-1 downto 0);


grant_out : out   master_slave

);

end arbiter_slave;

architecture a2 of arbiter_slave is

component mux_2to1_top2 is
    Port ( SEL : in  STD_LOGIC;
           A   : in  std_logic_vector(number_of_masters-1 downto 0);
           B   : in  std_logic_vector(number_of_masters-1 downto 0);
           X   : out std_logic_vector(number_of_masters-1 downto 0)
	);
end component;

signal help_grant: slave_master;
signal help_grant2: slave_master;
signal zero_grant: slave_master;


begin


arrayj: for j in number_of_slaves-1 downto 0 generate
		
		aw:mux_2to1_top2
		port map(

			SEL => enable(j),
			A => zero_grant(j),
			B => help_grant(j),
			X => help_grant2(j)
			);
			
end generate arrayj;




process(clk,reset)
begin

if reset ='0' then
	for i in 0 to number_of_slaves-1 loop
		help_grant(i) <= (others =>'0');
		zero_grant(i) <= (others =>'0');
	end loop;
		
else
	if (clk'event and clk='1') then
		help_grant <= grant_in;
	end if;
end if;
end process;

process(help_grant2)
begin
for i in 0 to number_of_masters-1 loop
	for j in 0 to number_of_slaves-1 loop	
		grant_out(i)(j) <= help_grant2(j)(i);
	end loop;
end loop;

end process;
	

end a2;






