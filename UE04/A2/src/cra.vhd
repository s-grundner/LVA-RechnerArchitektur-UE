--------------------------------------------------------------------------------
-- Full Adder
library ieee;
use ieee.std_logic_1164.all;

entity fa is
  port(
    a_i, b_i, carry_i : in  std_ulogic;
    carry_o, sum_o    : out std_ulogic
  );
end;

architecture rtl of fa is
begin
  sum_o <= a_i xor b_i xor carry_i;
  carry_o <= (a_i and b_i) or (carry_i and (a_i xor b_i));
end;

--------------------------------------------------------------------------------
-- Carry Ripple Adder
library ieee;
use ieee.std_logic_1164.all;

entity cra is
  generic(
    WIDTH : positive := 8
  );
  port(
    a_i, b_i  : in  std_ulogic_vector(WIDTH-1 downto 0);
    carry_i   : in  std_ulogic;
    carry_o   : out std_ulogic;
    sum_o     : out std_ulogic_vector(WIDTH-1 downto 0)
  );
end;

architecture rtl of cra is
  signal c : std_ulogic_vector(WIDTH downto 0);
begin
  c(0) <= carry_i;
  carry_o <= c(WIDTH);

  cra_gen : for i in 0 to WIDTH-1 generate
    fa_i : entity work.fa(rtl)
    port map(
      a_i     => a_i(i),
      b_i     => b_i(i),
      carry_i => c(i),
      carry_o => c(i+1),
      sum_o   => sum_o(i)
    );
  end generate cra_gen;
end;
