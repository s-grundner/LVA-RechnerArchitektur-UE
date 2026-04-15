--------------------------------------------------------------------------------
-- fa : Full Adder for two single bit inputs
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
-- adder : Carry Ripple Adder for bit vector
library ieee;
use ieee.std_logic_1164.all;

entity adder is
  generic(
    BW : positive := 8
  );
  port(
    a_i, b_i  : in  std_ulogic_vector(BW-1 downto 0);
    carry_i   : in  std_ulogic;
    carry_o   : out std_ulogic;
    carry2k_o : out std_ulogic;
    sum_o     : out std_ulogic_vector(BW-1 downto 0)
  );
end;

architecture rtl of adder is
  signal c : std_ulogic_vector(BW downto 0);
begin
  c(0) <= carry_i;
  carry_o <= c(BW);
  carry2k_o <= c(BW-1);

  carry_ripple_adder : for i in 0 to BW-1 generate
    fa_i : entity work.fa(rtl)
    port map(
      a_i     => a_i(i),
      b_i     => b_i(i),
      carry_i => c(i),
      carry_o => c(i+1),
      sum_o   => sum_o(i)
    );
  end generate;
end;

--------------------------------------------------------------------------------
-- add_sub : Addition / Subtraction of bit vectors
library ieee;
use ieee.std_logic_1164.all;

entity add_sub is
  generic(
    BW : positive := 8
  );
  port(
    a_i, b_i   : in  std_ulogic_vector(BW-1 downto 0);
    sub_i      : in  std_ulogic;
    result_o   : out std_ulogic_vector(BW-1 downto 0);
    overflow_o : out std_ulogic
  );
end;

architecture rtl of add_sub is
  signal b2k     : std_ulogic_vector(BW-1 downto 0) := (others => '0');
  signal carry2k : std_ulogic := '0';
  signal carry   : std_ulogic := '0';
begin
  b2k        <= b_i xor sub_i; -- negate for 2s complement
  overflow_o <= carry2k xor carry;

  adder : entity work.adder(rtl)
  port map (
    a_i       => a_i,
    b_i       => b2k,
    carry_i   => sub_i, -- +1 for 2s complement as carry in
    carry_o   => carry,
    carry2k_o => carry2k,
    sum_o     => result_o
  );
end;
