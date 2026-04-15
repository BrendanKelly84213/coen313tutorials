library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity add2bit is
    port ( 
           a : in std_logic_vector(1 downto 0);
           b : in std_logic_vector(1 downto 0);
           cin : in std_logic;
           sum : out std_logic_vector(1 downto 0);
           Cout : out std_logic);
end add2bit;

-- 1
-------
-- 1 1
-- 1 1
------
-- 1 0
-- C: 1
architecture behavioural of add2bit is
    component full_adder
        port (a : in std_logic;
              b : in std_logic;
              c_in : in std_logic;
              c_out : out std_logic;
              sum : out std_logic);
    end component;
    signal b0_cout : std_logic;
begin 
    i_b0 : full_adder port map ( a => a(0), b => b(0), c_in => cin, c_out => b0_cout, sum => sum(0) );
    i_b1 : full_adder port map ( a => a(1), b => b(1), c_in => b0_cout, c_out => Cout, sum => sum(1) );

end behavioural;
