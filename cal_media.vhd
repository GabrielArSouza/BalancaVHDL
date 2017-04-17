entity calcula_media is 
    generic ( w : natural := 8 );

    port ( bal_a, bal_b, bal_c, bal_d : in bit_vector (w-1 downto 0); -- entrada
	   media      : out bit_vector (w-1 downto 0)); -- media dos pesos
	   

end calcula_media;	   

architecture arch_med of calcula_media is

    -- fios
    signal c_in1, c_in2, c_in3, c_out1, c_out2, c_out3 : bit;
    signal fio1, fio2 : bit_vector (w-1 downto 0);  
    signal fio3 : bit_vector (w-1 downto 0);


    component adder_Wbits

        port (  a, b : in  bit_vector(w-1 downto 0); -- entradas
	cin  : in  bit;			     -- carry in
	s    : out bit_vector(w-1 downto 0); -- saídas
	cout : out bit); 		     -- carry out

    end component;

    component deslocador

	PORT(a : IN BIT_VECTOR (w-1 downto 0); -- entrada
	     s: OUT BIT_VECTOR (w-1 downto 0)); --saída

    end component;

    begin
	add1 : adder_Wbits port map (bal_a, bal_b, c_in1, fio1, c_out1);
	add2 : adder_Wbits port map (bal_c, bal_d, c_in2, fio2, c_out2);
	add3 : adder_Wbits port map (fio1, fio2, c_in3, fio3, c_out3);
	med : deslocador port map (fio3, media);

end arch_med;

