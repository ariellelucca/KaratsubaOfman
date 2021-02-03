library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ThreeBitMultiplier is
    Port ( 
        i_A  : in  STD_LOGIC_VECTOR(2 downto 0);
        i_B  : in  STD_LOGIC_VECTOR(2 downto 0);
        o_AB : out STD_LOGIC_VECTOR(5 downto 0)
    );
end ThreeBitMultiplier;

architecture Behavioral of ThreeBitMultiplier is
  signal w11_AND_A2B1 : STD_LOGIC;
  signal w12_AND_A1B2 : STD_LOGIC;
  signal w13_AND_A2B0 : STD_LOGIC;
  signal w14_AND_A0B2 : STD_LOGIC;
  signal w15_AND_A2B2 : STD_LOGIC;
  signal w16_AND_A1B1 : STD_LOGIC;
  signal w17_AND_A0B0 : STD_LOGIC;
  signal w18_AND_A1B0 : STD_LOGIC;
  signal w19_AND_A0B1 : STD_LOGIC;

  signal w21_XOR_A2B1_A1B2 : STD_LOGIC;
  signal w22_XOR_A2B0_A0B2 : STD_LOGIC;
  signal w23_XOR_A2B2_A1B1 : STD_LOGIC;
  signal w24_AND_A1B1_A0B0  : STD_LOGIC;
  signal w25_XOR_A1B0_A0B1 : STD_LOGIC;

  signal w31_LVL3_1 : STD_LOGIC;
  signal w32_LVL3_2 : STD_LOGIC;
  signal w33_LVL3_3 : STD_LOGIC;
  signal w34_LVL3_4 : STD_LOGIC;

  signal w41_LVL4_1 : STD_LOGIC;

  signal w51_LVL5_1 : STD_LOGIC;
  signal w52_LVL5_2 : STD_LOGIC;

  signal w61_LVL6_1 : STD_LOGIC;

  signal w71_LVL7_1 : STD_LOGIC;

  signal w81_LVL8_1 : STD_LOGIC;


  BEGIN
    w11_AND_A2B1 <= i_A(2) AND i_B(1); --
    w12_AND_A1B2 <= i_A(1) AND i_B(2); --
    w13_AND_A2B0 <= i_A(2) AND i_B(0); --
    w14_AND_A0B2 <= i_A(0) AND i_B(2); --
    w15_AND_A2B2 <= i_A(2) AND i_B(2); --
    w16_AND_A1B1 <= i_A(1) AND i_B(1); --
    w17_AND_A0B0 <= i_A(0) AND i_B(0); --
    w18_AND_A1B0 <= i_A(1) AND i_B(0); --
    w19_AND_A0B1 <= i_A(0) AND i_B(1); --

    w21_XOR_A2B1_A1B2 <= w11_AND_A2B1 XOR w12_AND_A1B2; --
    w22_XOR_A2B0_A0B2 <= w13_AND_A2B0 XOR w14_AND_A0B2; --
    w23_XOR_A2B2_A1B1 <= w15_AND_A2B2 XOR w16_AND_A1B1; -- 
    w24_AND_A1B1_A0B0 <= w16_AND_A1B1 AND not(w17_AND_A0B0); --
    w25_XOR_A1B0_A0B1 <= w18_AND_A1B0 XOR w19_AND_A0B1; --

    w31_LVL3_1 <= (w22_XOR_A2B0_A0B2 AND w24_AND_A1B1_A0B0); --
    w32_LVL3_2 <= (w22_XOR_A2B0_A0B2 XOR w24_AND_A1B1_A0B0); --
    w33_LVL3_3 <= (w23_XOR_A2B2_A1B1 AND w17_AND_A0B0); --
    w34_LVL3_4 <= (w15_AND_A2B2 AND (not(w24_AND_A1B1_A0B0))); --

    w41_LVL4_1 <= (w31_LVL3_1 OR w33_LVL3_3); --

    w51_LVL5_1 <= (w21_XOR_A2B1_A1B2 AND w41_LVL4_1); --
    w52_LVL5_2 <= (w21_XOR_A2B1_A1B2 XOR w41_LVL4_1); --

    w61_LVL6_1 <= (w51_LVL5_1 OR w34_LVL3_4); --

    w71_LVL7_1 <= (w61_LVL6_1 AND not(w16_AND_A1B1)); --

    w81_LVL8_1 <= (w71_LVL7_1 XOR w15_AND_A2B2);

    o_AB(5) <= w81_LVL8_1;
    o_AB(4) <= w61_LVL6_1;
    o_AB(3) <= w52_LVL5_2;
    o_AB(2) <= w32_LVL3_2; -- certo
    o_AB(1) <= w25_XOR_A1B0_A0B1; -- certo
    o_AB(0) <= w17_AND_A0B0; -- certo


end Behavioral;