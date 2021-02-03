library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ThreeToOneAdder is
    Port ( 
        i_A   : in  STD_LOGIC_VECTOR(4 downto 0);
        i_B   : in  STD_LOGIC_VECTOR(4 downto 0);
	i_CH  : in  STD_LOGIC_VECTOR(4 downto 0);
        o_ABC : out STD_LOGIC_VECTOR(4 downto 0)
    );
end ThreeToOneAdder;


architecture Behavioral of ThreeToOneAdder  is
   signal w_OUT3TO1 : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
   --signal w_IA      : STD_LOGIC_VECTOR(4 downto 0) := (others => '0'); 
   --signal w_IB      : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');

   BEGIN

   --w_IA <= 

   o_ABC <= i_A + i_B + i_CH;


end Behavioral;