library ieee; use ieee.std_logic_1164.all;
entity adder is
  port(a,b:  in std_ulogic_vector(15 downto 0);
       cin:  in std_ulogic;
       cout: out std_ulogic;
       sum:  out std_ulogic_vector(15 downto 0));
end;

--TODO implement conditional sum adder
architecture rtl_adder of adder is

  component fa
    port(
      a_i    : in  std_ulogic;
      b_i    : in  std_ulogic;
      cin_i  : in  std_ulogic;
      cout_o : out std_ulogic;
      z_o    : out std_ulogic
    );
  end component fa;

  component mux
    port(
      a_i   : in  std_ulogic;
      b_i   : in  std_ulogic;
      sel_i : in  std_ulogic;
      z_o   : out std_ulogic
    );
  end component mux;

  signal c_l : std_ulogic_vector(8 downto 0);
  signal c_h0, c_h1 : std_ulogic_vector(8 downto 0);
  signal s_h0, s_h1 : std_ulogic_vector(7 downto 0);

begin
  c_l(0) <= cin;
  
  gen_lower : for i in 0 to 7 generate
    fa_inst : component fa
      port map(
        a_i    => a(i),
        b_i    => b(i),
        cin_i  => c_l(i),
        cout_o => c_l(i + 1),
        z_o    => sum(i)
      );
    
  end generate gen_lower;
  
  -- Fall cin = 0
  c_h0(0) <= '0';

  gen_upper0 : for i in 0 to 7 generate
    fa1 : component fa
      port map(
        a_i    => a(i + 8),
        b_i    => b(i + 8),
        cin_i  => c_h0(i),
        cout_o => c_h0(i + 1),
        z_o    => s_h0(i)
      );
    
  end generate gen_upper0;
  
  -- Fall cin = 1
  c_h1(0) <= '1';
  gen_upper1 : for i in 0 to 7 generate
    fa1 : component fa
      port map(
        a_i    => a(i + 8),
        b_i    => b(i + 8),
        cin_i  => c_h1(i),
        cout_o => c_h1(i + 1),
        z_o    => s_h1(i)
      );
    
  end generate gen_upper1;
  
  gen_mux : for i in 0 to 7 generate
    mux_sum : component mux
      port map(
        a_i   => s_h1(i),
        b_i   => s_h0(i),
        sel_i => c_l(8),
        z_o   => sum(i + 8)
      );
    
  end generate gen_mux;

  --carry-out mux
  mux_cout : component mux
    port map(
      a_i   => c_h1(8),
      b_i   => c_h0(8),
      sel_i => c_l(8),
      z_o   => cout
    );
    
end architecture rtl_adder;