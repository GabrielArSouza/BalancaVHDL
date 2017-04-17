library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity comparator_Wbits is
    generic ( w : natural := 8);

    port ( a, b : in bit_vector(w-1 downto 0);
	   eq   : out std_logic;    -- a = b
	   gt   : out std_logic;    -- a > b
	   lt   : out std_logic);   -- a < b

end comparator_Wbits;

architecture arch_comp of comparator_Wbits is
begin
    lt <= '1' when (a < b) else '0';
    eq <= '1' when (a = b) else '0';
    gt <= '1' when (a > b) else '0';
end arch_comp;
		      
