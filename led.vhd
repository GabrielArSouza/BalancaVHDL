library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led is 

    port ( a, b, c : in std_logic;
	   resp    : out std_logic);

end led;


architecture arch_led of led is 
    
    begin
        resp <= ( b XOR c ) AND NOT a ;

end arch_led; 