library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity FourBitsMultiplier is
    Port ( 
        i_X  : in  STD_LOGIC_VECTOR(3 downto 0);
        i_Y  : in  STD_LOGIC_VECTOR(3 downto 0);
        o_XY : out STD_LOGIC_VECTOR(7 downto 0)
    );
end FourBitsMultiplier;


architecture Behavioral of FourBitsMultiplier is
  signal w_OUT3BITMULT : STD_LOGIC_VECTOR(5 downto 0);
  signal w_PARTIAL1    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
  signal w_PARTIAL2    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
  signal w_PARTIALCH   : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

  signal w_OUTSUM : STD_LOGIC_VECTOR(4 downto 0);

  BEGIN
    w_PARTIAL1(2) <= (i_X(3) AND i_Y(2));
    w_PARTIAL1(1) <= (i_X(3) AND i_Y(1));
    w_PARTIAL1(0) <= (i_X(3) AND i_Y(0));

    w_PARTIAL2(2) <= (i_Y(3) AND i_X(2));
    w_PARTIAL2(1) <= (i_Y(3) AND i_X(1));
    w_PARTIAL2(0) <= (i_Y(3) AND i_X(0));


    -- CORRETO
    w_OUT3BITMULT <= i_X(2 downto 0) * i_Y(2 downto 0);

    w_PARTIALCH(2 downto 0) <= w_OUT3BITMULT(5 downto 3);

    threebitadd: entity work.ThreeToOneAdder
      port map(
        i_A    => w_PARTIAL1,  
        i_B    => w_PARTIAL2,  
	i_CH   => w_PARTIALCH,
        o_ABC  => w_OUTSUM
     );

    -- certo mas verificar
    o_XY(7) <= w_OUTSUM(4) AND (i_X(3) AND i_Y(3));
    o_XY(6) <= w_OUTSUM(3) XOR (i_X(3) AND i_Y(3));
    o_XY(5 downto 3) <= w_OUTSUM(2 downto 0);
    o_XY(2 downto 0) <= w_OUT3BITMULT(2 downto 0);

end Behavioral;
