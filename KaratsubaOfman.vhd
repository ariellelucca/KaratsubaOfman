library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity KaratsubaOfman is
    Generic(
	Size  : natural := 64;
	WSize : natural := 8
    );
    Port ( 
        i_X    : in STD_LOGIC_VECTOR(Size-1 downto 0);
        i_Y    : in STD_LOGIC_VECTOR(Size-1 downto 0);
	i_CLK  : in std_logic;
	i_RSTn : in std_logic;
        o_XY   : out STD_LOGIC_VECTOR(2*Size-1 downto 0)
    );
end KaratsubaOfman;

architecture RecursiveArchitecture of KaratsubaOfman is
  -- ADD1 e ADD2
  -- OK
  signal r_X, r_Y: std_logic_vector (Size-1 downto 0);


  -- The two one-bit carryin of these additions are represented in by CX and CY respectively
  signal w_CIX : STD_LOGIC := '0';
  signal w_CIY : STD_LOGIC := '0';

  -- The two one-bit carryout of these additions are represented in by CX and CY respectively
  -- OK
  signal w_CX  : STD_LOGIC;
  signal w_CY  : STD_LOGIC;
  -- OK

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

  -- PRODUCTS
  signal w_P1  : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_P2  : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_P3  : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_PRODUCT3 : STD_LOGIC_VECTOR(Size+1 downto 0);


  -- ADDER
  signal w_ADD1_X : STD_LOGIC_VECTOR(Size/2-1 downto 0);
  signal w_ADD2_Y : STD_LOGIC_VECTOR(Size/2-1 downto 0);


  BEGIN 
    process(i_CLK, i_RSTn)
      begin
        if (i_RSTn = '0') then 
	  r_X <= (others => '0');
	  r_Y <= (others => '0');
        elsif (rising_edge(i_CLK)) then
          r_X <= i_X;
          r_Y <= i_Y;
        end if;
    end process;

    -- High X and High Y
    w_HX <= i_X(Size-1 downto Size/2);
    w_HY <= i_Y(Size-1 downto Size/2);

    -- Low X and Low Y
    w_LX <= i_X(Size/2-1 downto 0);
    w_LY <= i_Y(Size/2-1 downto 0);

    Termination: if Size <= WSize generate
	o_XY <= (others => '0') when (i_X = x"00" OR i_Y = x"00") else
		i_X * i_Y;
    end generate Termination;

      ADDl: entity work.Adder
        generic map ( 
          p_K => Size/2
        )
        port map(
          i_X1    => i_X(Size/2-1 downto 0),
          i_X2    => i_X(Size-1 downto Size/2),
          i_CARRY => w_CIX,
          o_XX    => w_ADD1_X, 
	  o_CARRY => w_CX
        );

       ADD2: entity work.Adder
        generic map ( 
          p_K => Size/2
        )
        port map(
          i_X1    => i_Y(Size/2-1 downto 0),
          i_X2    => i_Y(Size-1 downto Size/2),
          i_CARRY => w_CIY,
          o_XX    => w_ADD2_Y, 
	  o_CARRY => w_CY
        );

    Recursion: if Size > WSize generate


       -- REG ENTRADA
       KO1: entity work.KaratsubaOfman
         generic map (
           Size => Size/2
         )
         port map (
          i_X    => w_HX,
          i_Y    => w_HY,
          i_CLK => i_CLK,
          i_RSTn => i_RSTn,
          o_XY   => w_P1
        );

       -- REG ENTRADA
       KO2: entity work.KaratsubaOfman
         generic map (
           Size => Size/2
         )
         port map (
          i_X    => w_LX,
          i_Y    => w_LY,
	  i_CLK => i_CLK,
          i_RSTn => i_RSTn,
          o_XY   => w_P2
        );

       -- REG ENTRADA
       KO3: entity work.KaratsubaOfman
         generic map (
           Size => Size/2
         )
         port map (
          i_X    => w_ADD1_X,
          i_Y    => w_ADD2_Y,
	  i_CLK => i_CLK,
          i_RSTn => i_RSTn,
          o_XY   => w_P3
        );

       SA: entity work.ShiftnAdder
         generic map (
           p_K => Size/2
         )
         port map (
          i_CLK      => i_CLK,
          i_RSTn     => i_RSTn,
          i_SXL      => w_ADD1_X,
          i_SYL      => w_ADD2_Y,
	  i_CX       => w_CX,
          i_CY       => w_CY,
	  i_P        => w_P3,
          o_PRODUCT3 => w_PRODUCT3
        );

       -- REG SA�DA
       SSA: entity work.ShifterSubnAdder
         generic map (
           p_K => Size/2
         )
         port map (
          i_CLK      => i_CLK,
          i_RSTn     => i_RSTn,
          i_PRODUCT1 => w_P1,
          i_PRODUCT2 => w_P2,
	  i_PRODUCT3 => w_PRODUCT3,
          o_XY       => o_XY
        );


    end generate Recursion;

end RecursiveArchitecture;