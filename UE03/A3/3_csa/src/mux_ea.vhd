library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port (
        a_i : in std_ulogic;
        b_i : in std_ulogic;
        sel_i : in std_ulogic;
        z_o : out std_ulogic
    );
end entity mux;

architecture rtl_mux of mux is
begin
    z_o <= (b_i and not(sel_i)) or (a_i and sel_i);
end architecture rtl_mux;