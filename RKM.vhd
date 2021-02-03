
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RKM is
    Generic(
	Size: natural := 8
    );
    Port ( 
        i_X  : in STD_LOGIC_VECTOR(Size-1 downto 0);
        i_Y  : in STD_LOGIC_VECTOR(Size-1 downto 0);
        o_XY : out STD_LOGIC_VECTOR(2*Size-1 downto 0)
    );
end RKM;

architecture RecursiveArchitecture of RKM is
  -- High X and High Y
  -- OK
  signal w_HX  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  signal w_HY  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  -- OK

  -- Low X and Low Y
  -- OK
  signal w_LX  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  signal w_LY  : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  -- OK

  -- SHIFT N ADDER
  signal w_P1   : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_P2   : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_P3   : STD_LOGIC_VECTOR(Size-1 downto 0);

  -- declaration part including components and temporary signals

  BEGIN 
    -- High X and High Y
    w_HX <= i_X(Size-1 downto Size/2);
    w_HY <= i_Y(Size-1 downto Size/2);

    -- Low X and Low Y
    w_LX <= i_X(Size/2-1 downto 0);
    w_LY <= i_Y(Size/2-1 downto 0);


    FBM1: entity work.FourBitsMultiplier
      port map(
        i_X  => w_HX,  -- 7 downto 4
        i_Y  => w_HY,  -- 7 downto 4
        o_XY => w_P1
      );

    FBM2: entity work.FourBitsMultiplier
      port map(
        i_X  => w_LX,  -- 3 downto 0
        i_Y  => w_LY,  -- 3 downto 0
        o_XY => w_P2
      );


end RecursiveArchitecture;