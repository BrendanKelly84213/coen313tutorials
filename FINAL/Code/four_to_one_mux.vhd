library ieee;
use ieee.std_logic_1164.all;

entity four_to_one_mux is
    port(
        In1: in std_logic;
        In2: in std_logic;
        In3: in std_logic;
        In4: in std_logic;
        xy: in std_logic_vector(1 downto 0);
        loto: out std_logic
    );
end four_to_one_mux ;

architecture struct_four_to_one_mux of four_to_one_mux is
    component two_to_one_mux 
        port(
            a: in std_logic;
            b: in std_logic;
            sel: in std_logic;
            m_out: out std_logic
        );
    end component two_to_one_mux;

    signal mux0_out : std_logic := '0';
    signal mux1_out : std_logic := '0';
begin 
    i_mux0: two_to_one_mux port map(a => In1, b => In2, sel => xy(0), m_out => mux0_out);
    i_mux1: two_to_one_mux port map(a => In3, b => In4, sel => xy(0), m_out => mux1_out);
    i_mux2: two_to_one_mux port map(a => mux0_out, b => mux1_out, sel => xy(1), m_out => loto);

end struct_four_to_one_mux;
