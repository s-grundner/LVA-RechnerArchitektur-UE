-- generic counter based on adder and register
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

entity countdown is
  generic (width: integer);
  port(
    clk, reset: in  std_ulogic;
    y:          out std_ulogic_vector(width-1 downto 0);
    alarm:      out std_ulogic
  );
end;    

architecture struct of countdown is

  component ff is
    generic(
      width: integer;
      reset_val: std_ulogic_vector(width-1 downto 0)
    );
    port(
      clk, reset: in std_ulogic;
      d:          in std_ulogic_vector(width-1 downto 0);
      q:         out std_ulogic_vector(width-1 downto 0)
    );
  end component;

  component ff_single is
    generic(
      reset_val: std_ulogic
    );
    port(
      clk, reset: in std_ulogic;
      d:          in std_ulogic;
      q:         out std_ulogic
    );
  end component;

  signal q_s:       std_ulogic_vector(width-1 downto 0);
  signal d_s:       std_ulogic_vector(width-1 downto 0);
  signal carry_s:   std_ulogic_vector(width-1 downto 0);
  signal zero_s:    std_ulogic;

begin

  carry_s(0) <= '1';
  d_s(0)     <= not q_s(0);

  gen_dec_logic: for i in 1 to width-1 generate
    carry_s(i) <= carry_s(i-1) and (not q_s(i-1));
    d_s(i)     <= q_s(i) xor carry_s(i);
  end generate;

  zero_s <= carry_s(width-1) and (not q_s(width-1));

  y <= q_s;
  
  counter_ff: ff
    generic map(
      width     => width,
      reset_val => (width-1 downto 0 => '1')
    )
    port map(
      clk   => clk,
      reset => reset,
      d     => d_s,
      q     => q_s
    );

  alarm_ff: ff_single
    generic map(
      reset_val => '0'
    )
    port map(
      clk   => clk,
      reset => reset,
      d     => zero_s,
      q     => alarm
    );
end;









