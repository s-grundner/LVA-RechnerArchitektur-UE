library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.pkg_riscv_sc.all;

entity extend_rd is
    port(
        LoadType_i : in std_ulogic_vector(LOAD_INSTR_TYPE_SIZE - 1 downto 0);
        ReadData_i : in std_ulogic_vector(31 downto 0);
        RDExt_o : out std_ulogic_vector(31 downto 0)
    );
end entity extend_rd;

architecture bhv_extend_rd of extend_rd is    
begin
    RDExt_o <=  (31 downto 8 => ReadData_i(7)) & ReadData_i(7 downto 0)     when LoadType_i = LOAD_BYTE_TYPE else
                (31 downto 16 => ReadData_i(15)) & ReadData_i(15 downto 0)  when LoadType_i = LOAD_HALF_TYPE else
                ReadData_i                                                  when LoadType_i = LOAD_WORD_TYPE else
                (31 downto 8 => '0') & ReadData_i(7 downto 0)               when LoadType_i = LOAD_BYTE_U_TYPE else
                (31 downto 16 => '0') & ReadData_i(15 downto 0)             when LoadType_i = LOAD_HALF_U_TYPE else
                (others => 'X');
end architecture bhv_extend_rd;

