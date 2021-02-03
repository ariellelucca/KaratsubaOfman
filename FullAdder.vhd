library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity FullAdder is
  Port ( 
   i_A    : in  STD_LOGIC_VECTOR(0 downto 0);
   i_B    : in  STD_LOGIC_VECTOR(0 downto 0);
   i_CIN  : in  STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
   o_RES  : out STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
   o_COUT : out STD_LOGIC_VECTOR(0 downto 0) := (others => '0')
  );
end FullAdder;
 
architecture Behavioral of FullAdder is
   begin
     o_RES  <= i_A XOR i_B XOR i_CIN ;
     o_COUT <= ((i_A AND i_B) OR (i_CIN AND i_A) OR (i_CIN AND i_B));
end Behavioral;
