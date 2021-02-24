library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity VedicMult8x8 is
    Port ( 
        i_A : in STD_LOGIC_VECTOR(7 downto 0);
        i_B : in STD_LOGIC_VECTOR(7 downto 0)
    );
end VedicMult8x8;


architecture Behavioral of VedicMult8x8 is

  signal w_R1   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

  signal w_AB1  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  signal o_COUT : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

  begin
-- A0 X B0
	w_AB1(0 downto 0) <= (i_A(0 downto 0) AND i_B(0 downto 0));
        o_COUT(0 downto 0) <= "0";

-- A0 X B1 + A1 X B0
        w_R1(1 downto 0) <= ((i_A(0 downto 0) * i_B(1 downto 1)) + (i_A(1 downto 1) * i_B(0 downto 0))) ;
	w_AB1(1 downto 1)  <= w_R1(0 downto 0);
        o_COUT(1 downto 1) <= w_R1(1 downto 1);

-- A0 X B2 + A2 X B0 + A2 X B2
	w_R1(3 downto 2) <= ((i_A(0 downto 0) * i_B(2 downto 2)) + 
			    (i_A(2 downto 2) * i_B(0 downto 0))  + 
			    (i_A(2 downto 2) * i_B(2 downto 2))  + 
                             o_COUT(1 downto 1));

	w_AB1(2 downto 2)  <= w_R1(2 downto 2);
        o_COUT(2 downto 2) <= w_R1(3 downto 3);

-- A0 X B3 + A3 X B0 + A1 X B2 + A2 X B1
	w_R1(5 downto 4) <= ((i_A(0 downto 0) * i_B(3 downto 3)) + 
			    (i_A(3 downto 3) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(2 downto 2))  + 
			    (i_A(2 downto 2) * i_B(1 downto 1))  +
                             o_COUT(2 downto 2));

	w_AB1(3 downto 3)  <= w_R1(4 downto 4);
        o_COUT(3 downto 3) <= w_R1(5 downto 5);

-- A0 X B4 + A4 X B0 + A1 X B3 + A3 X B1 + A2 X B2
	w_R1(7 downto 6) <= ((i_A(0 downto 0) * i_B(4 downto 4)) + 
			    (i_A(4 downto 4) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(3 downto 3))  +
			    (i_A(3 downto 3) * i_B(1 downto 1))  +
			    (i_A(2 downto 2) * i_B(2 downto 2))  +
                             o_COUT(3 downto 3));

	w_AB1(4 downto 4)  <= w_R1(6 downto 6);
        o_COUT(4 downto 4) <= w_R1(7 downto 7);

-- A0 X B5 + A5 X B0 + A1 X B4 + A4 X B1 + A3 X B2 + A2 X B3

	w_R1(9 downto 8) <= ((i_A(0 downto 0) * i_B(5 downto 5)) + 
			    (i_A(5 downto 5) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(4 downto 4))  + 
			    (i_A(4 downto 4) * i_B(1 downto 1))  + 
			    (i_A(3 downto 3) * i_B(2 downto 2))  + 
			    (i_A(2 downto 2) * i_B(3 downto 3))  + 
                             o_COUT(4 downto 4));

	w_AB1(5 downto 5)  <= w_R1(8 downto 8);
        o_COUT(5 downto 5) <= w_R1(9 downto 9);

-- A0 X B6 + A6 X B0 + A1 X B5 + A5 X B1 + A2 X B4 + A4 X B2 + A3 X B3

	w_R1(11 downto 10) <= ((i_A(0 downto 0) * i_B(6 downto 6)) + 
			    (i_A(6 downto 6) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(1 downto 1))  + 
			    (i_A(2 downto 2) * i_B(4 downto 4))  + 
			    (i_A(4 downto 4) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(3 downto 3))  + 
                             o_COUT(5 downto 5));

	w_AB1(6 downto 6)  <= w_R1(10 downto 10);
        o_COUT(6 downto 6) <= w_R1(11 downto 11);


-- A0 X B7 + A7 X B0 + A1 X B6 + A6 X B1 + A2 X B5 + A5 X B2 + A3 X B4 + A4 X B3

	w_R1(13 downto 12) <= ((i_A(0 downto 0) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(0 downto 0))  + 
			    (i_A(1 downto 1) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(1 downto 1))  + 
			    (i_A(2 downto 2) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(4 downto 4))  + 
			    (i_A(4 downto 4) * i_B(3 downto 3))  + 
                             o_COUT(6 downto 6));

	w_AB1(7 downto 7)  <= w_R1(12 downto 12);
        o_COUT(7 downto 7) <= w_R1(13 downto 13);



-- A1 X B7 + A7 X B1 + A2 X B6 + A6 X B2 + A3 X B5 + A5 X B3 + A4 X B4

	w_R1(15 downto 14) <= ((i_A(1 downto 1) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(1 downto 1))  + 
			    (i_A(2 downto 2) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(3 downto 3))  + 
			    (i_A(4 downto 4) * i_B(4 downto 4))  + 
                             o_COUT(7 downto 7));

	w_AB1(8 downto 8)  <= w_R1(14 downto 14);
        o_COUT(8 downto 8) <= w_R1(15 downto 15);


-- A2 X B7 + A7 X B2 + A3 X B6 + A6 X B3 + A4 X B5 + A5 X B4 

	w_R1(17 downto 16) <= ((i_A(2 downto 2) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(2 downto 2))  + 
			    (i_A(3 downto 3) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(3 downto 3))  + 
			    (i_A(4 downto 4) * i_B(5 downto 5))  + 
			    (i_A(5 downto 5) * i_B(4 downto 4))  + 
                             o_COUT(8 downto 8));

	w_AB1(9 downto 9)  <= w_R1(16 downto 16);
        o_COUT(9 downto 9) <= w_R1(17 downto 17);

-- A3 X B7 + A7 X B3 + A4 X B6 + A6 X B4 + A5 X B5

	w_R1(19 downto 18) <= ((i_A(3 downto 3) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(3 downto 3))  + 
			    (i_A(4 downto 4) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(4 downto 4))  + 
			    (i_A(5 downto 5) * i_B(5 downto 5))  + 
                             o_COUT(9 downto 9));

	w_AB1(10 downto 10)  <= w_R1(18 downto 18);
        o_COUT(10 downto 10) <= w_R1(19 downto 19);

-- A4 X B7 + A7 X B4 + A5 X B6 + A6 X B5

	w_R1(21 downto 20) <= ((i_A(4 downto 4) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(4 downto 4))  + 
			    (i_A(5 downto 5) * i_B(6 downto 6))  + 
			    (i_A(6 downto 6) * i_B(5 downto 5))  + 
                             o_COUT(10 downto 10));

	w_AB1(11 downto 11)  <= w_R1(20 downto 20);
        o_COUT(11 downto 11) <= w_R1(21 downto 21);

-- A5 X B7 + A7 X B5 + A6 X B6

	w_R1(23 downto 22) <= ((i_A(5 downto 5) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(5 downto 5))  + 
			    (i_A(6 downto 6) * i_B(6 downto 6))  + 
                             o_COUT(11 downto 11));

	w_AB1(12 downto 12)  <= w_R1(22 downto 22);
        o_COUT(12 downto 12) <= w_R1(23 downto 23);

-- A6 X B7 + A7 X B6

	w_R1(25 downto 24) <= ((i_A(6 downto 6) * i_B(7 downto 7)) + 
			    (i_A(7 downto 7) * i_B(6 downto 6))  + 
                             o_COUT(12 downto 12));

	w_AB1(13 downto 13)  <= w_R1(24 downto 24);
        o_COUT(13 downto 13) <= w_R1(25 downto 25);


-- A7 X B7

	w_R1(25 downto 24) <= ((i_A(7 downto 7) * i_B(7 downto 7)) + 
			     o_COUT(13 downto 13));

	w_AB1(15 downto 14)  <= w_R1(25 downto 24);

end Behavioral;