--------------------------------------------------------------------------------
-- Multiplier
library ieee;
use ieee.std_logic_1164.all;

entity mult is
  generic (
    WIDTH : positive := 16
  );
  port(
    a : in std_ulogic_vector(WIDTH-1 downto 0);
    b : in std_ulogic_vector(WIDTH-1 downto 0);
    y : out std_ulogic_vector(2*WIDTH-1 downto 0)
  );
end;

architecture rtl of mult is

  type partials_array is array (0 to WIDTH-1) of std_ulogic_vector(WIDTH-1 downto 0);
  signal partials : partials_array;

  type partials_shift_array is array (0 to WIDTH-1) of std_ulogic_vector(2*WIDTH-1 downto 0);
  signal partials_shift : partials_shift_array := (others => (others => '0'));

  type results_array is array (0 to WIDTH) of std_ulogic_vector(2*WIDTH-1 downto 0);
  signal result : results_array;
  signal carry : std_ulogic_vector(WIDTH downto 0) := (others => '0');

begin

  y         <= result(WIDTH);
  result(0) <= (others => '0');
  carry(0)  <= '0';

  gen_partial : for i in 0 to WIDTH-1 generate
    partials(i) <= (WIDTH-1 downto 0 => a(i)) and b;
    partials_shift(i)(WIDTH-1+i downto i) <= partials(i);
  end generate gen_partial;

  gen_result : for i in 0 to WIDTH-1 generate
    cra_inst: entity work.cra(rtl)
      generic map(
        WIDTH => 2*WIDTH
      )
      port map(
        a_i     => result(i),
        b_i     => partials_shift(i),
        carry_i => carry(i),
        carry_o => carry(i+1),
        sum_o   => result(i+1)
      );
  end generate;
end;
