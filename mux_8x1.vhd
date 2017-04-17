library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mux_8x1_Wbits is
    generic ( w : natural := 8);
    
    port ( a0, a1, a2, a3,
	   a4, a5, a6, a7 : in bit_vector (w-1 downto 0);  -- data inputs
	   s0, s1, s2     : in std_logic;		   -- seletores
	   s              : out bit_vector (w-1 downto 0)); -- saida
end mux_8x1_Wbits;

architecture arch_mux of mux_8x1_Wbits is
-- a0 igual (p)
-- a1 maior (p-m) 
-- a2 menor (m-p)
begin
   PROCESS(s0,s1,s2, a0, a1, a2, a5)
   BEGIN 
      IF(s0='1') THEN  --igual
         s <= a1;
      ELSIF(s1='1') THEN --maior
  	 s <= a2;
      ELSE
	 s <= a3;
      END IF;
   END PROCESS; 
end arch_mux;
