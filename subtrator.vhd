ENTITY sub_Wbits IS
GENERIC (w : natural := 8);

PORT (  a, b : in  bit_vector(w-1 downto 0); -- entradas
	cin  : in  bit;			     -- carry in
	s    : out bit_vector(w-1 downto 0); -- sa�das
	cout : out bit); 		     -- carry out

END sub_Wbits;

ARCHITECTURE arch_sub OF sub_Wbits IS
    -- declara��o de sinais
    signal carry : bit_vector ( w downto 0 ); -- carry in interno

begin
    carry (0) <= cin;
    f0: for i in (w-1) downto 0 generate

	s(i) 	   <= a(i) XOR b(i) XOR carry(i);
	carry(i+1) <= (not a(i) AND b(i)) OR 
		      (not a(i) AND carry(i)) OR
		      ( b(i) AND carry(i));

	end generate f0;

    cout <= carry(w);

end arch_sub;
