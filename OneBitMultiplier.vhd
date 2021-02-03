library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity OneBitMultiplier is
    Generic (
	p_K : in natural
    );
    Port ( 
        i_X  : in  STD_LOGIC_VECTOR(p_K-1 downto 0);
        i_Y  : in  STD_LOGIC_VECTOR(p_K-1 downto 0);
        o_XY : out STD_LOGIC_VECTOR(2*p_K-1 downto 0)
    );
end OneBitMultiplier;


architecture Behavioral of OneBitMultiplier is
  BEGIN
    o_XY <= (i_X * i_Y);
end Behavioral;
