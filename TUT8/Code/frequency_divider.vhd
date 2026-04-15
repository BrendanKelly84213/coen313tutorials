library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity frequency_divider is
    port( clk : in std_logic;
          reset : in std_logic;
          c : in std_logic_vector(3 downto 0);
          pulse : out std_logic);
end frequency_divider;

architecture behavioural of frequency_divider is
    signal counter : unsigned(14 downto 0);
    signal m : integer; 
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif (rising_edge(clk)) then
            if (counter < 2**15 - 1) then
                counter <= counter + 1;
            else 
                counter <= (others => '0');
            end if;

        end if;
    end process;

    m <= to_integer(unsigned(c));

    pulse <= counter(m - 1) when m > 0 else 
             clk;
end behavioural;

