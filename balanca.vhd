library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity balanca is 
    generic ( w : natural := 8 );

    port ( p1, p2, p3, p4 : in  bit_vector (w-1 downto 0); -- entradas
	   r1, r2, r3, r4 : out bit_vector (w-1 downto 0); -- resultado de cada peso
 	   l1, l2, l3, l4 : out std_logic);			   -- leds

end balanca; 


-------------------------------------------------------------------------

architecture arch_final of balanca is 

    -- Fios
    -- fio de saída da média
    signal f_med : bit_vector (w-1 downto 0);

    -- fio das saídas de cada comparação
    signal fc1_s0, fc1_s1, fc1_s2 : std_logic;
    signal fc2_s0, fc2_s1, fc2_s2 : std_logic;
    signal fc3_s0, fc3_s1, fc3_s2 : std_logic;
    signal fc4_s0, fc4_s1, fc4_s2 : std_logic;

    -- fios das subtrações
    signal sub_pm1, sub_pm2, sub_pm3, sub_pm4 : bit_vector (w-1 downto 0);
    signal sub_mp1, sub_mp2, sub_mp3, sub_mp4 : bit_vector (w-1 downto 0);
    signal c_in1, c_in2, c_in3, c_in4, c_in5, c_in6, c_in7, c_in8 : bit; -- cin de cada subtração
    signal c_out1, c_out2, c_out3, c_out4, c_out5, c_out6, c_out7, c_out8 : bit; -- cout de cada subtração


    component comparator_Wbits

        port ( a, b : in bit_vector(w-1 downto 0);
	eq   : out std_logic;    -- a = b
	gt   : out std_logic;    -- a > b
	lt   : out std_logic);   -- a < b
	
    end component;

    component calcula_media
	
	port ( bal_a, bal_b, bal_c, bal_d : in bit_vector (w-1 downto 0); -- entrada
        media  : out bit_vector (w-1 downto 0)); -- media dos pesos

    end component;

    component sub_Wbits
	
	port (  a, b : in  bit_vector (w-1 downto 0); -- entradas
	cin  : in  bit;			     -- carry in
	s    : out bit_vector (w-1 downto 0); -- saídas
	cout : out bit); 		     -- carry out

    end component;

    component mux_8x1_Wbits
	
	port ( a0, a1, a2, a3,
	   a4, a5, a6, a7 : in bit_vector (w-1 downto 0);  -- data inputs
	   s0, s1, s2     : in std_logic;		   -- seletores
	   s              : out bit_vector (w-1 downto 0)); -- saida

    end component;

   
    component led

	port ( a, b, c : in std_logic;
	resp    : out std_logic);

    end component;
   
    signal v : bit_vector (w-1 downto 0) := "00000000";

    begin
	-- pegar media
	med : calcula_media port map (p1, p2, p3, p4, f_med );

	-- fazer subtrações peso - media
	subpm1 : sub_Wbits port map (p1, f_med, c_in1, sub_pm1, c_out1);
	subpm2 : sub_Wbits port map (p2, f_med, c_in2, sub_pm2, c_out2);
	subpm3 : sub_Wbits port map (p3, f_med, c_in3, sub_pm3, c_out3);
	subpm4 : sub_Wbits port map (p4, f_med, c_in4, sub_pm4, c_out4);

	-- fazer subtrações media - peso
	submp1 : sub_Wbits port map (f_med, p1, c_in5, sub_mp1, c_out5);
	submp2 : sub_Wbits port map (f_med, p2, c_in6, sub_mp2, c_out6);
	submp3 : sub_Wbits port map (f_med, p3, c_in7, sub_mp3, c_out7);
	submp4 : sub_Wbits port map (f_med, p4, c_in8, sub_mp4, c_out8);

	-- fazer comparações
	comp1 : comparator_Wbits port map (p1, f_med, fc1_s0, fc1_s1, fc1_s2);
	comp2 : comparator_Wbits port map (p2, f_med, fc2_s0, fc2_s1, fc2_s2);
	comp3 : comparator_Wbits port map (p3, f_med, fc3_s0, fc3_s1, fc3_s2);
	comp4 : comparator_Wbits port map (p4, f_med, fc4_s0, fc4_s1, fc4_s2);
   
	-- juntar a galera
	mux1 : mux_8x1_Wbits port map (p1, sub_pm1, sub_mp1, v, v, v, v, v, fc1_s0, fc1_s1, fc1_s2, r1); 
	mux2 : mux_8x1_Wbits port map (p2, sub_pm2, sub_mp2, v, v, v, v, v, fc2_s0, fc2_s1, fc2_s2, r2);
	mux3 : mux_8x1_Wbits port map (p3, sub_pm3, sub_mp3, v, v, v, v, v, fc3_s0, fc3_s1, fc3_s2, r3);
	mux4 : mux_8x1_Wbits port map (p4, sub_pm4, sub_mp4, v, v, v, v, v, fc4_s0, fc4_s1, fc4_s2, r4);

	-- ligar led
	led1 : led port map (fc1_s0, fc1_s1, fc1_s2, l1);
	led2 : led port map (fc2_s0, fc2_s1, fc2_s2, l2);
	led3 : led port map (fc3_s0, fc3_s1, fc3_s2, l3);
	led4 : led port map (fc4_s0, fc4_s1, fc4_s2, l4);

end arch_final;