library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use std.textio.all;





package DEMO_PACK is
  --constant SOME_FLAG : bit_vector := "11111111";


constant number_of_masters:  integer:=2;
constant number_of_slaves:  integer:=4;
constant number_of_components: integer := 9;
constant adress_width : integer := 32;

constant data_width: integer:=8;
constant M: integer:= 8;	-- data width of queue
constant N: integer:=16;	-- depth of queue


subtype master_size is std_logic_vector (number_of_masters-1 downto 0);
subtype slave_size is std_logic_vector (number_of_slaves-1 downto 0);
subtype data is std_logic_vector (data_width-1 downto 0);
subtype data_size is std_logic_vector (data_width-1 downto 0);
subtype adress_size is std_logic_vector (adress_width-1 downto 0);



type slave_data is array(number_of_slaves-1 downto 0) of data;
type master_data is array( number_of_masters-1 downto 0) of data;

type master_slave_data is array ( number_of_masters-1 downto 0) of slave_data;
type slave_master_data is array (number_of_slaves-1 downto 0) of master_data;

-----------adress ARRAY
type master_adress is array( number_of_masters-1 downto 0) of adress_size;
type slave_adress is array( number_of_slaves-1 downto 0) of adress_size;


type master_slave_adress is array(number_of_masters-1 downto 0) of slave_adress;
type slave_master_adress is array(number_of_slaves-1 downto 0) of master_adress;

----------------


type master_slave is array(number_of_masters-1 downto 0) of slave_size;
type slave_master is array(number_of_slaves-1 downto 0) of master_size;

subtype components_size is std_logic_vector (number_of_components-1 downto 0);
type master_components is array(number_of_masters-1 downto 0) of components_size;
type slave_components is array(number_of_slaves-1 downto 0) of components_size;

type components_masters is array(number_of_components-1 downto 0) of master_size;

type components_components is array(number_of_components-1 downto 0) of components_size;


subtype name_type37 is string(1 to 37) ;
type string_array37 is array(0 to number_of_components-1 ) of name_type37;

subtype name_type44 is string(1 to 44) ;
type string_array44 is array(0 to number_of_components-1 ) of name_type44;

subtype name_type45 is string(1 to 45) ;
type string_array45 is array(0 to number_of_components-1 ) of name_type45;


subtype name_type41 is string(1 to 41) ;
type string_array41 is array(0 to number_of_components-1 ) of name_type41;

subtype name_type53 is string(1 to 53) ;
type string_array53 is array(0 to number_of_components-1 ) of name_type53;

subtype name_type43 is string(1 to 43) ;
type string_array43 is array(0 to number_of_components-1 ) of name_type43;

subtype name_type50 is string (1 to 50);
type string_array50 is array(0 to number_of_components-1) of name_type50;

constant input_files : string_array44 := ("C:\Users\Alex\Desktop\inputs\input.data0.txt", "C:\Users\Alex\Desktop\inputs\input.data1.txt","C:\Users\Alex\Desktop\inputs\input.data2.txt", "C:\Users\Alex\Desktop\inputs\input.data3.txt", "C:\Users\Alex\Desktop\inputs\input.data4.txt", "C:\Users\Alex\Desktop\inputs\input.data5.txt", "C:\Users\Alex\Desktop\inputs\input.data6.txt", "C:\Users\Alex\Desktop\inputs\input.data7.txt", "C:\Users\Alex\Desktop\inputs\input.data8.txt")  ;
constant desti_files : string_array44 := ("C:\Users\Alex\Desktop\destis\desti.data0.txt", "C:\Users\Alex\Desktop\destis\desti.data1.txt","C:\Users\Alex\Desktop\destis\desti.data2.txt", "C:\Users\Alex\Desktop\destis\desti.data3.txt", "C:\Users\Alex\Desktop\destis\desti.data4.txt", "C:\Users\Alex\Desktop\destis\desti.data5.txt", "C:\Users\Alex\Desktop\destis\desti.data6.txt", "C:\Users\Alex\Desktop\destis\desti.data7.txt", "C:\Users\Alex\Desktop\destis\desti.data8.txt") ;


constant time_files : string_array41 := ("C:\Users\Alex\Desktop\time\time.data0.txt","C:\Users\Alex\Desktop\time\time.data1.txt","C:\Users\Alex\Desktop\time\time.data2.txt","C:\Users\Alex\Desktop\time\time.data3.txt","C:\Users\Alex\Desktop\time\time.data4.txt","C:\Users\Alex\Desktop\time\time.data5.txt","C:\Users\Alex\Desktop\time\time.data6.txt","C:\Users\Alex\Desktop\time\time.data7.txt","C:\Users\Alex\Desktop\time\time.data8.txt");
constant RW_files : string_array53 :=  ( "C:\Users\Alex\Desktop\read_write\read_write.data0.txt","C:\Users\Alex\Desktop\read_write\read_write.data1.txt","C:\Users\Alex\Desktop\read_write\read_write.data2.txt","C:\Users\Alex\Desktop\read_write\read_write.data3.txt","C:\Users\Alex\Desktop\read_write\read_write.data4.txt","C:\Users\Alex\Desktop\read_write\read_write.data5.txt","C:\Users\Alex\Desktop\read_write\read_write.data6.txt","C:\Users\Alex\Desktop\read_write\read_write.data7.txt","C:\Users\Alex\Desktop\read_write\read_write.data8.txt");
constant read_inputs_files : string_array43 := ("C:\Users\Alex\Desktop\inputs\read.data0.txt", "C:\Users\Alex\Desktop\inputs\read.data1.txt","C:\Users\Alex\Desktop\inputs\read.data2.txt", "C:\Users\Alex\Desktop\inputs\read.data3.txt", "C:\Users\Alex\Desktop\inputs\read.data4.txt", "C:\Users\Alex\Desktop\inputs\read.data5.txt", "C:\Users\Alex\Desktop\inputs\read.data6.txt", "C:\Users\Alex\Desktop\inputs\read.data7.txt", "C:\Users\Alex\Desktop\inputs\read.data8.txt")  ;

constant adress_files: string_array45 := ("C:\Users\Alex\Desktop\adress\adress.data0.txt","C:\Users\Alex\Desktop\adress\adress.data1.txt","C:\Users\Alex\Desktop\adress\adress.data2.txt","C:\Users\Alex\Desktop\adress\adress.data3.txt","C:\Users\Alex\Desktop\adress\adress.data4.txt","C:\Users\Alex\Desktop\adress\adress.data5.txt","C:\Users\Alex\Desktop\adress\adress.data6.txt","C:\Users\Alex\Desktop\adress\adress.data7.txt","C:\Users\Alex\Desktop\adress\adress.data8.txt");

constant inject_files: string_array53 := ( "C:\Users\Alex\Desktop\Injected-Times\inject.data0.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data1.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data2.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data3.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data4.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data5.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data6.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data7.txt","C:\Users\Alex\Desktop\Injected-Times\inject.data8.txt");



subtype name_output is string(1 to 46) ;
type string_output is array(0 to number_of_components-1) of name_output;
constant output_files : string_output := ("C:\Users\Alex\Desktop\outputs\output.data0.txt", "C:\Users\Alex\Desktop\outputs\output.data1.txt","C:\Users\Alex\Desktop\outputs\output.data2.txt", "C:\Users\Alex\Desktop\outputs\output.data3.txt","C:\Users\Alex\Desktop\outputs\output.data4.txt","C:\Users\Alex\Desktop\outputs\output.data5.txt","C:\Users\Alex\Desktop\outputs\output.data6.txt","C:\Users\Alex\Desktop\outputs\output.data7.txt","C:\Users\Alex\Desktop\outputs\output.data8.txt");
constant output_adress_files : string_output :=("C:\Users\Alex\Desktop\outputs\adress.data0.txt", "C:\Users\Alex\Desktop\outputs\adress.data1.txt","C:\Users\Alex\Desktop\outputs\adress.data2.txt", "C:\Users\Alex\Desktop\outputs\adress.data3.txt","C:\Users\Alex\Desktop\outputs\adress.data4.txt","C:\Users\Alex\Desktop\outputs\adress.data5.txt","C:\Users\Alex\Desktop\outputs\adress.data6.txt","C:\Users\Alex\Desktop\outputs\adress.data7.txt","C:\Users\Alex\Desktop\outputs\adress.data8.txt");



constant memory_files : string_output := ("C:\Users\Alex\Desktop\memorys\output.data0.txt", "C:\Users\Alex\Desktop\memorys\output.data1.txt","C:\Users\Alex\Desktop\memorys\output.data2.txt", "C:\Users\Alex\Desktop\memorys\output.data3.txt","C:\Users\Alex\Desktop\memorys\output.data4.txt","C:\Users\Alex\Desktop\memorys\output.data5.txt","C:\Users\Alex\Desktop\memorys\output.data6.txt","C:\Users\Alex\Desktop\memorys\output.data7.txt","C:\Users\Alex\Desktop\memorys\output.data8.txt");



-- prints a message to the screen
    procedure print(text: string);

    -- prints the message when active
    -- useful for debug switches
    procedure print(active: boolean; text: string);

    -- converts std_logic into a character
    function chr(sl: std_logic) return character;

    -- converts std_logic into a string (1 to 1)
    function str(sl: std_logic) return string;

    -- converts std_logic_vector into a string (binary base)
    function str(slv: std_logic_vector) return string;

    -- converts boolean into a string
    function str(b: boolean) return string;

    -- converts an integer into a single character
    -- (can also be used for hex conversion and other bases)
    function chr(int: integer) return character;

    -- converts integer into string using specified base
    function str(int: integer; base: integer) return string;

    -- converts integer to string, using base 10
    function str(int: integer) return string;

    -- convert std_logic_vector into a string in hex format
    function hstr(slv: std_logic_vector) return string;


    -- functions to manipulate strings
    -----------------------------------

    -- conver decimal string into usnigned
    function decimal_string_to_unsigned(decimal_string: string; wanted_bitwidth: positive) return unsigned;

    -- convert a character to upper case
    function to_upper(c: character) return character;

    -- convert a character to lower case
    function to_lower(c: character) return character;

    -- convert a string to upper case
    function to_upper(s: string) return string;

    -- convert a string to lower case
    function to_lower(s: string) return string;

   
    
    -- functions to convert strings into other formats
    --------------------------------------------------
    
    -- converts a character into std_logic
    function to_std_logic(c: character) return std_logic; 
    
    -- converts a string into std_logic_vector
    function to_std_logic_vector(s: string) return std_logic_vector; 

    -- converts a string into integer
    function string_to_int(x_str : string; radix : positive range 2 to 36 := 10) return integer;


    ------CROSSBAR FABRIC FUNCTION

	Function sel_ip (inputlength : integer) return integer;
  
    -- file I/O
    -----------
       
    -- read variable length string from input file
    procedure str_read(file in_file: TEXT; 
                       res_string: out string);
        
    -- print string to a file and start new line
    procedure print(file out_file: TEXT;
                    new_string: in  string);
    
    -- print character to a file and start new line
    procedure print(file out_file: TEXT;
                    char:       in  character);


                    
end DEMO_PACK;




package body DEMO_PACK is






   -- prints text to the screen

   procedure print(text: string) is
     variable msg_line: line;
     begin
       write(msg_line, text);
       writeline(output, msg_line);
   end print;




   -- prints text to the screen when active

   procedure print(active: boolean; text: string)  is
     begin
      if active then
         print(text);
      end if;
   end print;


   -- converts std_logic into a character

   function chr(sl: std_logic) return character is
    variable c: character;
    begin
      case sl is
         when 'U' => c:= 'U';
         when 'X' => c:= 'X';
         when '0' => c:= '0';
         when '1' => c:= '1';
         when 'Z' => c:= 'Z';
         when 'W' => c:= 'W';
         when 'L' => c:= 'L';
         when 'H' => c:= 'H';
         when '-' => c:= '-';
      end case;
    return c;
   end chr;



   -- converts std_logic into a string (1 to 1)

   function str(sl: std_logic) return string is
    variable s: string(1 to 1);
    begin
        s(1) := chr(sl);
        return s;
   end str;



   -- converts std_logic_vector into a string (binary base)
   -- (this also takes care of the fact that the range of
   --  a string is natural while a std_logic_vector may
   --  have an integer range)

   function str(slv: std_logic_vector) return string is
     variable result : string (1 to slv'length);
     variable r : integer;
   begin
     r := 1;
     for i in slv'range loop
        result(r) := chr(slv(i));
        r := r + 1;
     end loop;
     return result;
   end str;


   function str(b: boolean) return string is

    begin
       if b then
          return "true";
      else
        return "false";
       end if;
    end str;


   -- converts an integer into a character
   -- for 0 to 9 the obvious mapping is used, higher
   -- values are mapped to the characters A-Z
   -- (this is usefull for systems with base > 10)
   -- (adapted from Steve Vogwell's posting in comp.lang.vhdl)

   function chr(int: integer) return character is
    variable c: character;
   begin
        case int is
          when  0 => c := '0';
          when  1 => c := '1';
          when  2 => c := '2';
          when  3 => c := '3';
          when  4 => c := '4';
          when  5 => c := '5';
          when  6 => c := '6';
          when  7 => c := '7';
          when  8 => c := '8';
          when  9 => c := '9';
          when 10 => c := 'A';
          when 11 => c := 'B';
          when 12 => c := 'C';
          when 13 => c := 'D';
          when 14 => c := 'E';
          when 15 => c := 'F';
          when 16 => c := 'G';
          when 17 => c := 'H';
          when 18 => c := 'I';
          when 19 => c := 'J';
          when 20 => c := 'K';
          when 21 => c := 'L';
          when 22 => c := 'M';
          when 23 => c := 'N';
          when 24 => c := 'O';
          when 25 => c := 'P';
          when 26 => c := 'Q';
          when 27 => c := 'R';
          when 28 => c := 'S';
          when 29 => c := 'T';
          when 30 => c := 'U';
          when 31 => c := 'V';
          when 32 => c := 'W';
          when 33 => c := 'X';
          when 34 => c := 'Y';
          when 35 => c := 'Z';
          when others => c := '?';
        end case;
        return c;
    end chr;



   -- convert integer to string using specified base
   -- (adapted from Steve Vogwell's posting in comp.lang.vhdl)

   function str(int: integer; base: integer) return string is

    variable temp:      string(1 to 10);
    variable num:       integer;
    variable abs_int:   integer;
    variable len:       integer := 1;
    variable power:     integer := 1;

   begin

    -- bug fix for negative numbers
    abs_int := abs(int);

    num     := abs_int;

    while num >= base loop                     -- Determine how many
      len := len + 1;                          -- characters required
      num := num / base;                       -- to represent the
    end loop ;                                 -- number.

    for i in len downto 1 loop                 -- Convert the number to
      temp(i) := chr(abs_int/power mod base);  -- a string starting
      power := power * base;                   -- with the right hand
    end loop ;                                 -- side.

    -- return result and add sign if required
    if int < 0 then
       return '-'& temp(1 to len);
     else
       return temp(1 to len);
    end if;

   end str;


  -- convert integer to string, using base 10
  function str(int: integer) return string is

   begin

    return str(int, 10) ;

   end str;



   -- converts a std_logic_vector into a hex string.
   function hstr(slv: std_logic_vector) return string is
       variable hexlen: integer;
       variable longslv : std_logic_vector(67 downto 0) := (others => '0');
       variable hex : string(1 to 16);
       variable fourbit : std_logic_vector(3 downto 0);
     begin
       hexlen := (slv'left+1)/4;
       if (slv'left+1) mod 4 /= 0 then
         hexlen := hexlen + 1;
       end if;
       longslv(slv'left downto 0) := slv;
       for i in (hexlen -1) downto 0 loop
         fourbit := longslv(((i*4)+3) downto (i*4));
         case fourbit is
           when "0000" => hex(hexlen -I) := '0';
           when "0001" => hex(hexlen -I) := '1';
           when "0010" => hex(hexlen -I) := '2';
           when "0011" => hex(hexlen -I) := '3';
           when "0100" => hex(hexlen -I) := '4';
           when "0101" => hex(hexlen -I) := '5';
           when "0110" => hex(hexlen -I) := '6';
           when "0111" => hex(hexlen -I) := '7';
           when "1000" => hex(hexlen -I) := '8';
           when "1001" => hex(hexlen -I) := '9';
           when "1010" => hex(hexlen -I) := 'A';
           when "1011" => hex(hexlen -I) := 'B';
           when "1100" => hex(hexlen -I) := 'C';
           when "1101" => hex(hexlen -I) := 'D';
           when "1110" => hex(hexlen -I) := 'E';
           when "1111" => hex(hexlen -I) := 'F';
           when "ZZZZ" => hex(hexlen -I) := 'z';
           when "UUUU" => hex(hexlen -I) := 'u';
           when "XXXX" => hex(hexlen -I) := 'x';
           when others => hex(hexlen -I) := '?';
         end case;
       end loop;
       return hex(1 to hexlen);
     end hstr;



   -- functions to manipulate strings
   -----------------------------------

-- decimal string to unsigned

function decimal_string_to_unsigned(decimal_string: string; wanted_bitwidth: positive) return unsigned is
  variable tmp_unsigned: unsigned(wanted_bitwidth-1 downto 0) := (others => '0');
  variable character_value: integer;
begin
  for string_pos in decimal_string'range loop
    case decimal_string(string_pos) is
      when '0' => character_value := 0;
      when '1' => character_value := 1;
      when '2' => character_value := 2;
      when '3' => character_value := 3;
      when '4' => character_value := 4;
      when '5' => character_value := 5;
      when '6' => character_value := 6;
      when '7' => character_value := 7;
      when '8' => character_value := 8;
      when '9' => character_value := 9;
      when others => report("Illegal number") severity failure;
    end case;
    tmp_unsigned := resize(tmp_unsigned * 10, wanted_bitwidth);
    tmp_unsigned := tmp_unsigned + character_value;
  end loop;
  return tmp_unsigned;
end decimal_string_to_unsigned;






   -- convert a character to upper case

   function to_upper(c: character) return character is

      variable u: character;

    begin

       case c is
        when 'a' => u := 'A';
        when 'b' => u := 'B';
        when 'c' => u := 'C';
        when 'd' => u := 'D';
        when 'e' => u := 'E';
        when 'f' => u := 'F';
        when 'g' => u := 'G';
        when 'h' => u := 'H';
        when 'i' => u := 'I';
        when 'j' => u := 'J';
        when 'k' => u := 'K';
        when 'l' => u := 'L';
        when 'm' => u := 'M';
        when 'n' => u := 'N';
        when 'o' => u := 'O';
        when 'p' => u := 'P';
        when 'q' => u := 'Q';
        when 'r' => u := 'R';
        when 's' => u := 'S';
        when 't' => u := 'T';
        when 'u' => u := 'U';
        when 'v' => u := 'V';
        when 'w' => u := 'W';
        when 'x' => u := 'X';
        when 'y' => u := 'Y';
        when 'z' => u := 'Z';
        when others => u := c;
    end case;

      return u;

   end to_upper;


   -- convert a character to lower case

   function to_lower(c: character) return character is

      variable l: character;

    begin

       case c is
        when 'A' => l := 'a';
        when 'B' => l := 'b';
        when 'C' => l := 'c';
        when 'D' => l := 'd';
        when 'E' => l := 'e';
        when 'F' => l := 'f';
        when 'G' => l := 'g';
        when 'H' => l := 'h';
        when 'I' => l := 'i';
        when 'J' => l := 'j';
        when 'K' => l := 'k';
        when 'L' => l := 'l';
        when 'M' => l := 'm';
        when 'N' => l := 'n';
        when 'O' => l := 'o';
        when 'P' => l := 'p';
        when 'Q' => l := 'q';
        when 'R' => l := 'r';
        when 'S' => l := 's';
        when 'T' => l := 't';
        when 'U' => l := 'u';
        when 'V' => l := 'v';
        when 'W' => l := 'w';
        when 'X' => l := 'x';
        when 'Y' => l := 'y';
        when 'Z' => l := 'z';
        when others => l := c;
    end case;

      return l;

   end to_lower;



   -- convert a string to upper case

   function to_upper(s: string) return string is

     variable uppercase: string (s'range);

   begin

     for i in s'range loop
        uppercase(i):= to_upper(s(i));
     end loop;
     return uppercase;

   end to_upper;



   -- convert a string to lower case

   function to_lower(s: string) return string is

     variable lowercase: string (s'range);

   begin

     for i in s'range loop
        lowercase(i):= to_lower(s(i));
     end loop;
     return lowercase;

   end to_lower;



-- functions to convert strings into other types


-- converts a character into a std_logic

function to_std_logic(c: character) return std_logic is 
    variable sl: std_logic;
    begin
      case c is
        when 'U' => 
           sl := 'U'; 
        when 'X' =>
           sl := 'X';
        when '0' => 
           sl := '0';
        when '1' => 
           sl := '1';
        when 'Z' => 
           sl := 'Z';
        when 'W' => 
           sl := 'W';
        when 'L' => 
           sl := 'L';
        when 'H' => 
           sl := 'H';
        when '-' => 
           sl := '-';
        when others =>
           sl := 'X'; 
    end case;
   return sl;
  end to_std_logic;


-- converts a string into std_logic_vector

function to_std_logic_vector(s: string) return std_logic_vector is 
  variable slv: std_logic_vector(s'high-s'low downto 0);
  variable k: integer;
begin
   k := s'high-s'low;
  for i in s'range loop
     slv(k) := to_std_logic(s(i));
     k      := k - 1;
  end loop;
  return slv;
end to_std_logic_vector;                                       
                                       
                                       
       ---------CROSSBAR FABRIC

Function sel_ip (inputlength : integer) return integer is
   variable retlength : integer range 0 to 16;

 begin
   for i in 0 to 4 loop
     if ( (2 ** i) >= inputlength ) then
    	retlength := i - 1;
    	exit;
     end if;
   end loop;
   return retlength;
   end sel_ip;   

                             
                                       
                                       
                                       
----------------
--  file I/O  --
----------------



-- read variable length string from input file
     
procedure str_read(file in_file: TEXT; 
                   res_string: out string) is
       
       variable l:         line;
       variable c:         character;
       variable is_string: boolean;
       
   begin
           
     readline(in_file, l);
     -- clear the contents of the result string
     for i in res_string'range loop
         res_string(i) := ' ';
     end loop;   
     -- read all characters of the line, up to the length  
     -- of the results string
     for i in res_string'range loop
        read(l, c, is_string);
        res_string(i) := c;
        if not is_string then -- found end of line
           exit;
        end if;   
     end loop; 
                     
end str_read;


-- print string to a file
procedure print(file out_file: TEXT;
                new_string: in  string) is
       
       variable l: line;
       
   begin
      
     write(l, new_string);
     writeline(out_file, l);
                     
end print;


-- print character to a file and start new line
procedure print(file out_file: TEXT;
                char: in  character) is
       
       variable l: line;
       
   begin
      
     write(l, char);
     writeline(out_file, l);
                     
end print;



-- appends contents of a string to a file until line feed occurs
-- (LF is considered to be the end of the string)

procedure str_write(file out_file: TEXT; 
                    new_string: in  string) is
 begin
      
   for i in new_string'range loop
      print(out_file, new_string(i));
      if new_string(i) = LF then -- end of string
         exit;
      end if;
   end loop;               
                     
end str_write;

-- here is something extra

----------------------------------------------------------------------
  --Will take a string in the given radix and conver it to an integer
  ----------------------------------------------------------------------
  function string_to_int(x_str : string; radix : positive range 2 to 36 := 10) return integer is
    constant STR_LEN          : integer := x_str'length;
    
    variable chr_val          : integer;
    variable ret_int          : integer := 0;
    variable do_mult          : boolean := true;
    variable power            : integer := 0;
  begin
    
    for i in 1 to STR_LEN loop
      case x_str(i) is
        when '0'       =>   chr_val := 0;
        when '1'       =>   chr_val := 1;
        when '2'       =>   chr_val := 2;
        when '3'       =>   chr_val := 3;
        when '4'       =>   chr_val := 4;
        when '5'       =>   chr_val := 5;
        when '6'       =>   chr_val := 6;
        when '7'       =>   chr_val := 7;
        when '8'       =>   chr_val := 8;
        when '9'       =>   chr_val := 9;
        when 'A' | 'a' =>   chr_val := 10;
        when 'B' | 'b' =>   chr_val := 11;
        when 'C' | 'c' =>   chr_val := 12;
        when 'D' | 'd' =>   chr_val := 13;
        when 'E' | 'e' =>   chr_val := 14;
        when 'F' | 'f' =>   chr_val := 15;
        when 'G' | 'g' =>   chr_val := 16;
        when 'H' | 'h' =>   chr_val := 17;
        when 'I' | 'i' =>   chr_val := 18;
        when 'J' | 'j' =>   chr_val := 19;
        when 'K' | 'k' =>   chr_val := 20;
        when 'L' | 'l' =>   chr_val := 21;
        when 'M' | 'm' =>   chr_val := 22;
        when 'N' | 'n' =>   chr_val := 23;
        when 'O' | 'o' =>   chr_val := 24;
        when 'P' | 'p' =>   chr_val := 25;
        when 'Q' | 'q' =>   chr_val := 26;
        when 'R' | 'r' =>   chr_val := 27;
        when 'S' | 's' =>   chr_val := 28;
        when 'T' | 't' =>   chr_val := 29;
        when 'U' | 'u' =>   chr_val := 30;
        when 'V' | 'v' =>   chr_val := 31;
        when 'W' | 'w' =>   chr_val := 32;
        when 'X' | 'x' =>   chr_val := 33;
        when 'Y' | 'y' =>   chr_val := 34;
        when 'Z' | 'z' =>   chr_val := 35;                           
        when '-' =>   
          if i /= 1 then
            report "Minus sign must be at the front of the string" severity failure;
          else
            ret_int           := 0 - ret_int;
            chr_val           := 0;
            do_mult           := false;    --Minus sign - do not do any number manipulation
          end if;
                     
        when others => report "Illegal character for conversion for string to integer" severity failure;
      end case;
      
      if chr_val >= radix then report "Illagel character at this radix" severity failure; end if;
        
      if do_mult then
        ret_int               := ret_int + (chr_val * (radix**power));
      end if;
        
      power                   := power + 1;
          
    end loop;
    
    return ret_int;
    
  end function;





end DEMO_PACK;















