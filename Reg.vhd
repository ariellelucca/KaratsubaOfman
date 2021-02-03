library ieee ;
use ieee.std_logic_1164.all ;

entity Reg is
  generic ( 
    r_N : integer := 8
  );
  port (
    i_R  : in STD_LOGIC_VECTOR(r_N-1 DOWNTO 0) ;
    i_RST: IN STD_LOGIC;
    i_CLK: IN STD_LOGIC;
    o_R  : OUT STD_LOGIC_VECTOR(r_N-1 DOWNTO 0) 
  );
end Reg;


architecture Behavioral OF Reg IS
  BEGIN
    PROCESS
      BEGIN
        WAIT UNTIL i_CLK'EVENT AND i_CLK = '1';
        IF i_RST = '1' 
          THEN 
	    o_R <= i_R;
        END IF;
    END PROCESS;
END Behavioral;