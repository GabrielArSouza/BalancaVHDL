ENTITY deslocador IS
    GENERIC (w : natural := 8);
    PORT(a : IN BIT_VECTOR (w-1 downto 0); -- entrada
	s: OUT BIT_VECTOR (w-1 downto 0)); --saída
END deslocador;

ARCHITECTURE arch_desl OF deslocador IS
BEGIN

    f0: for i in (w-3) downto 0 generate

	s(i) 	   <= a(i+2);

    end generate f0;


END arch_desl;
