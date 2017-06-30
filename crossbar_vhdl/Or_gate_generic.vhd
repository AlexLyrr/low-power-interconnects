library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.DEMO_PACK.all;

Entity OR_gate_gen is

  GENERIC (n : INTEGER := 3);

  port   ( 
		A: in std_logic_vector(n-1 downto 0);
		C: out std_logic

	 );

end OR_gate_gen;

Architecture a1 of OR_gate_gen is

begin

process (A)
variable RESULT: std_logic;
begin
RESULT := '0';

for i in 0 to n-1 loop
	RESULT := RESULT or A(i);
end loop;
C <= RESULT;
end process;

end a1;



