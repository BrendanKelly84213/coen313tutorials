library ieee;
use ieee.std_logic_1164.all;

entity two_to_one_mux is
    port(
        a: in std_logic;
        b: in std_logic;
        sel: in std_logic;
        m_out: out std_logic);
end two_to_one_mux ;

architecture my_mux of two_to_one_mux is
begin
    m_out <= a when sel = '0' else 
             b;
end my_mux;
