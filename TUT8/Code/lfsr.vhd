library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lfsr is
    port( 
          clk, reset : in std_logic;
          seed : in std_logic_vector(7 downto 0);
          lfsr_out : out std_logic_vector(7 downto 0)
      );
end lfsr;

architecture behavioural of lfsr is 
    signal reg : std_logic_vector(7 downto 0);
begin
    process(clk, reset)
    begin
        if (reset = '1') then
            reg <= seed;
        elsif (rising_edge(clk)) then
           reg <= reg(reg'high - 1 downto reg'low) & (reg(4) xor reg(3) xor reg(2) xor reg(0));
        end if;
    end process;

    lfsr_out <= reg;
end behavioural;
