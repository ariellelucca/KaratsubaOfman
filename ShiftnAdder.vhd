library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ShiftnAdder is
    Generic (
	p_K : in natural := 4
    );
    Port ( 
        i_CLK     : in std_logic;
        i_RSTn    : in std_logic;
        i_SXL     : in STD_LOGIC_VECTOR(p_K-1 downto 0); -- valor soma x
        i_SYL     : in STD_LOGIC_VECTOR(p_K-1 downto 0); -- valor soma y
	i_CX      : in STD_LOGIC; -- carry x 
        i_CY      : in STD_LOGIC; -- carry y 
        i_P       : in STD_LOGIC_VECTOR(2*p_K-1 downto 0); -- P
        o_PRODUCT3: out STD_LOGIC_VECTOR(2*p_K+1 downto 0)
    );
end ShiftnAdder;

architecture Behavioral of ShiftnAdder is
    signal r_D1, r_D2 : STD_LOGIC_VECTOR(p_K-1 downto 0);
    signal r_D3, r_D4 : STD_LOGIC;
    signal r_D5       : STD_LOGIC_VECTOR(2*p_K-1 downto 0);

    signal w_S         : STD_LOGIC_VECTOR(p_K downto 0);
    signal w_S1        : STD_LOGIC_VECTOR(2*p_K+1 downto 0) := (others => '0');
    signal w_CONCATS   : STD_LOGIC_VECTOR(2*p_K+1 downto 0) := (others => '0');
    signal w_T         : STD_LOGIC;
    signal w_TP        : STD_LOGIC_VECTOR(2*p_K+1 downto 0) := (others => '0');
    signal w_DES       : STD_LOGIC_VECTOR(p_K-1 downto 0):= (others => '0');
    signal w_ADD1_X    : STD_LOGIC_VECTOR(p_K-1 downto 0); 
    signal w_CX : STD_LOGIC;

   BEGIN 
    process(i_CLK, i_RSTn)
      begin
        if (i_RSTn = '0') then 
          r_D1 <= (others => '0');
          r_D2 <= (others => '0');
          r_D3 <= '0';
          r_D4 <= '0';
          r_D5 <= (others => '0'); 
        elsif (rising_edge(i_CLK)) then
          r_D1 <= i_SXL;
          r_D2 <= i_SYL;
          r_D3 <= i_CX;
          r_D4 <= i_CY;
          r_D5 <= i_P;
        end if;
    end process;

      ADDl: entity work.Adder
        generic map ( 
          p_K => p_K
        )
        port map(
          i_X1    => i_SXL,
          i_X2    => i_SYL,
          i_CARRY => '0',
          o_XX    => w_ADD1_X, 
	  o_CARRY => w_CX
        );


    -- The component ShiftnAdd (in Figure 5 ) first computes the sum S as SXl+ SYl,SXl,SYl
       w_S <= (w_CX & w_ADD1_X) when (i_CX = '1' AND i_CY = '1') else   -- CERTO
               '0'&i_SXL when (i_CX = '0' AND i_CY = '1') else
               '0'&i_SYL when (i_CX = '1' AND i_CY= '0') else
               (others => '0');
   
    -- T represents CX.CY
       w_T <= i_CX AND i_CY;

    -- w_S1 represents w_S with concat
       w_S1 <= w_CONCATS + (w_S & w_DES);

    -- TP
       w_TP <= w_CONCATS + (w_T & i_P);

       o_PRODUCT3 <= w_TP + w_S1;

end Behavioral;

