library ieee; use ieee.std_logic_1164.all;
entity fa is
  port(a,b,cin: in std_ulogic;
       cout, s: out std_ulogic);
end;

architecture rtl of fa is
begin
  s <= a xor b xor cin;
  cout <= (a and b) or (cin and (a xor b));
end;

library ieee; use ieee.std_logic_1164.all;
entity adder is
  port(a,b:  in std_ulogic_vector(7 downto 0);
       cin:  in std_ulogic;
       cout: out std_ulogic;
       sum:  out std_ulogic_vector(7 downto 0));
end;

architecture rtl of adder is
  signal c : std_ulogic_vector(8 downto 0);
begin
  c(0) <= cin;
  
  carry_ripple_adder : for i in 0 to 7 generate
    fa_i: entity work.fa(rtl)
      port map(
        a    => a(i),
        b    => b(i),
        cin  => c(i),
        cout => c(i+1),
        s    => sum(i)
      );
  end generate;
  
  cout <= c(8);
end rtl;

library ieee; use ieee.std_logic_1164.all;
entity comparator is
  port(a, b: in std_ulogic_vector(7 downto 0);
       result: out std_ulogic_vector(1 downto 0));
end;

architecture rtl of comparator is

  signal not_b : std_ulogic_vector(7 downto 0);
  signal diff : std_ulogic_vector(7 downto 0);
  signal cout : std_ulogic;

  signal z01, z23, z45, z67 : std_ulogic;
  signal z0123, z4567 : std_ulogic;
  signal zero : std_ulogic;

begin
  not_b <= not b;
  sub : entity work.adder(rtl)
    port map(
      a => a,
      b => not_b,
      cin => '1',
      cout => cout,
      sum => diff
    );

  z01 <= not(diff(0) or diff(1));
  z23 <= not(diff(2) or diff(3));
  z45 <= not(diff(4) or diff(5));
  z67 <= not(diff(6) or diff(7));

  z0123 <= z01 and z23;
  z4567 <= z45 and z67;
  zero <= z0123 and z4567;

  result(0) <= not cout;
  result(1) <= cout xor zero;

end rtl;