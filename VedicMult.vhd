
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity VedicMult is
    Generic (
	p_K : in natural := 8
    );
    Port ( 
        i_X    : in STD_LOGIC_VECTOR(p_K-1 downto 0);
        i_Y    : in STD_LOGIC_VECTOR(p_K-1 downto 0);
    );
end VedicMult;


architecture Behavioral of VedicMult is

  -- Carrys intermediários
  signal w_CIN : STD_LOGIC_VECTOR(p_K downto 0) := (others => '0');
  signal w_COUT: STD_LOGIC_VECTOR(p_K downto 0) := (others => '0');


      begin
      Addition: for i in 0 to p_K-1 generate
        F_ADDER: entity work.FullAdder 
	  port map( 
  	    i_A    => i_X1  (i downto i), 
	    i_B    => i_X2  (i downto i), 
	    i_CIN  => w_CIN (i downto i),
	    o_RES  => o_XX  (i downto i), 
	    o_COUT => w_COUT(i+1 downto i+1)
	  );

         w_CIN <= w_COUT;

      end generate Addition;
   o_CARRY <= w_COUT(p_K);
end Behavioral;