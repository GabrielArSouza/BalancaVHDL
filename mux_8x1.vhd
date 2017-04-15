library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux_8x1_Wbits is
    generic ( w : natural := 8);
    
    port ( a0, a1, a2, a3,
	   a4, a5, a6, a7 : in bit_vector (w-1 downto 0);  -- data inputs
	   s0, s1, s2     : in std_logic;		   -- seletores
	   s              : out bit_vector (w-1 downto 0); -- saida
end mux_8x1_Wbits;

architecture arch_mux od mux_8x1_Wbits is
begin
    f0 : FOR i IN (w-1) downto 0 generate
	 s(i) <= (a(i) AND

