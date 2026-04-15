library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity p1 is
    port ( ctrl : in std_logic;
           a : in std_logic_vector(1 downto 0);
           b : in std_logic_vector(1 downto 0);
           sum : out std_logic_vector(1 downto 0);
           Cout : out std_logic);
end p1;

architecture fa_arch of p1 is
    component full_adder
    port ( 
           a : in std_logic;
           b : in std_logic;
           c_in : in std_logic;
           c_out : out std_logic;
           sum : out std_logic);
    end component;

    signal mux_out : std_logic_vector(1 downto 0) := (others => '0');
    signal sum_ab : std_logic_vector(1 downto 0) := (others => '0');
    signal cout_ab : std_logic_vector(1 downto 0) := (others => '0');

    signal sum_abctrl : std_logic_vector(1 downto 0) := (others => '0');
    signal cout_abctrl : std_logic_vector(1 downto 0) := (others => '0');
    signal cout_null : std_logic;
begin
    mux_out <= b when ctrl = '0' else
               not b;
    
    i_fa_ab0 : full_adder port map(a => a(0), b => mux_out(0), c_in => '0', sum => sum_ab(0), c_out => cout_ab(0));
    i_fa_ab1 : full_adder port map(a => a(1), b => mux_out(1), c_in => cout_ab(0), sum => sum_ab(1), c_out => cout_ab(1));

    -- (a + mux_out) + ctrl
    i_fa_abctrl0 : full_adder port map(a => sum_ab(0), b => ctrl, c_in => '0', sum => sum_abctrl(0), c_out => cout_abctrl(0));
    i_fa_abctrl1 : full_adder port map(a => sum_ab(1), b => '0', c_in => cout_abctrl(0), sum => sum_abctrl(1), c_out => cout_abctrl(1));
    i_fa_abctrl2 : full_adder port map(a => cout_ab(1), b => '0', c_in => cout_abctrl(1), sum => Cout, c_out => cout_null);

    sum <= sum_abctrl;

end fa_arch;

