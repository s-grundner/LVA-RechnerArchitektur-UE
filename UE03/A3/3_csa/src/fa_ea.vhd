library ieee;
use ieee.std_logic_1164.all;

entity fa is
    port (
        a_i : in std_ulogic;
        b_i : in std_ulogic;
        cin_i : in std_ulogic;
        cout_o : out std_ulogic;
        z_o : out std_ulogic
    );
end fa;

architecture rtl_fa of fa is
begin
    z_o <= a_i xor b_i xor cin_i;
    cout_o <= (a_i and b_i) or (a_i and cin_i) or (b_i and cin_i);
end architecture rtl_fa;