library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4 is
    port (
        a_i : in std_ulogic_vector(31 downto 0);
        b_i : in std_ulogic_vector(31 downto 0);
        c_i : in std_ulogic_vector(31 downto 0);
        d_i : in std_ulogic_vector(31 downto 0);
        sel_i : in std_ulogic_vector(1 downto 0);
        z_o : out std_ulogic_vector(31 downto 0)
    );
end entity mux_4;

architecture bhv_mux_4 of mux_4 is    
begin    
    z_o <=  a_i when sel_i = "00" else
            b_i when sel_i = "01" else
            c_i when sel_i = "10" else
            d_i when sel_i = "11";

end architecture bhv_mux_4;
