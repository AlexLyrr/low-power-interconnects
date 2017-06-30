library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

entity crossbar_arbiter is 


port (

		clk   : in    std_logic;
		reset : in    std_logic;
		req_arbiter   : in    slave_master;
		grant_arbiter : out   slave_master
	

);

end crossbar_arbiter;

architecture a2 of crossbar_arbiter is
	
component rrarbiter 
	port (
		clk   : in    std_logic;
		reset : in    std_logic;
		req   : in    std_logic_vector(number_of_masters-1 downto 0);
		grant : out   std_logic_vector(number_of_masters-1 downto 0)
	);
end component;


begin




arrayi: for i in 0 to number_of_slaves-1 generate

sw: rrarbiter 
		port map(
			clk => clk,
			reset => reset,
			req => req_arbiter(i),
			grant => grant_arbiter(i)
			);



end generate arrayi;

	
	
end a2;















