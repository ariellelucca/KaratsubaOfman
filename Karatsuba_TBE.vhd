library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Karatsuba_TBE is
    Generic(
	Size  : natural := 16;
	WSize : natural := 16
    );
end Karatsuba_TBE;

architecture arch_1 of Karatsuba_TBE is
    signal w_X   : STD_LOGIC_VECTOR(Size-1 downto 0);
    signal w_Y   : STD_LOGIC_VECTOR(Size-1 downto 0);
    signal w_CLK : STD_LOGIC := '0';
    signal w_RSTn: STD_LOGIC := '0';
    signal w_XY  : STD_LOGIC_VECTOR(2*Size-1 downto 0);
begin 

  KO1: entity work.KaratsubaOfman
    generic map (
      Size => Size,
      WSize => WSize
    )
    port map (
     i_X    => w_X,
     i_Y    => w_Y,
     i_CLK  => w_CLK,
     i_RSTn => w_RSTn,
     o_XY   => w_XY
   );
  
process 
begin

w_RSTn <= '1';
w_X <= "0001110100100001";
w_Y <= "1110101111100011";

wait for 1 ps;
w_CLK <= '1';
wait for 1 ps;
w_CLK <= '0';
wait for 1 ps;
w_CLK <= '1';
wait for 1 ps;
w_CLK <= '0';
wait for 1 ps;
w_CLK <= '1';
wait for 1 ps;
w_CLK <= '0';
wait for 1 ps;
w_CLK <= '1';
wait for 1 ps;
w_CLK <= '0';
wait for 1 ps;
w_CLK <= '1';
wait for 1 ps;
w_CLK <= '0';
wait for 1 ps;
w_CLK <= '1';
wait for 1 ps;
w_CLK <= '0';
wait for 1 ps;
w_CLK <= '1';
wait for 1 ps;
w_CLK <= '0';

end process;

end arch_1;