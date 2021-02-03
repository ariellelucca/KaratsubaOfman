library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity product3 is
    Generic(
	Size: natural := 4
    );
    Port ( 
        i_XH  : in STD_LOGIC_VECTOR(Size-1 downto 0);
        i_YH  : in STD_LOGIC_VECTOR(Size-1 downto 0);
        i_XL  : in STD_LOGIC_VECTOR(Size-1 downto 0);
        i_YL  : in STD_LOGIC_VECTOR(Size-1 downto 0);
        o_XY : out STD_LOGIC_VECTOR(2*Size downto 0)
    );
end product3;

architecture Behavioral of product3 is
  signal w_SXL: STD_LOGIC_VECTOR(Size-1 downto 0)   := (others => '0');
  signal w_SYL: STD_LOGIC_VECTOR(Size-1 downto 0)   := (others => '0');
  signal w_CIX: STD_LOGIC := '0'; 
  signal w_CIY: STD_LOGIC := '0';
  signal w_P  : STD_LOGIC_VECTOR(2*Size-1 downto 0);
  signal w_FOURBIT  : STD_LOGIC_VECTOR(7 downto 0);
  signal w_PRODUCT3 : STD_LOGIC_VECTOR(2*Size downto 0);
  signal w_CX  : STD_LOGIC := '0';
  signal w_CY  : STD_LOGIC := '0';


  BEGIN
     ADDl: entity work.Adder
      generic map ( 
        p_K => Size -- 16 = 8
      )
      port map(
        i_X1    => i_XH,  -- 7 downto 0
        i_X2    => i_XL,  -- 7 downto 0
        i_CARRY => w_CIX,
        o_XX    => w_SXL, 
	o_CARRY => w_CX
      );

  
    ADD2: entity work.Adder
      generic map ( 
        p_K => Size -- 16 = 8
      )
      port map(
        i_X1    => i_YH,     -- 7 downto 0
        i_X2    => i_YL,  -- 7 downto 0
        i_CARRY => w_CIY,
        o_XX    => w_SYL, 
	o_CARRY => w_CY
      );

    -- GERA O P
    FBM: entity work.FourBitsMultiplier
      generic map ( 
        p_K => Size-1 -- 16 = 8
      )
      port map(
        i_X  => w_SXL,     -- 7 downto 0
        i_Y  => w_SYL,  -- 7 downto 0
        o_XY => w_P
      );

    SHIFTNADD: entity work.ShiftnAdder
      generic map ( 
        p_K => Size -- 16 = 8
      )
      port map(
        i_SXL  => w_SXL,  -- 7 downto 0
        i_SYL  => w_SYL,  -- 7 downto 0
	i_CX  => w_CX,
	i_CY  => w_CY,
	i_P   => w_P,
        o_PRODUCT3  => w_PRODUCT3
      );


    o_XY <= w_PRODUCT3;

end Behavioral;