library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity seven_segment is
    port( input_bin : in std_logic_vector(3 downto 0);
          led_out   : out std_logic_vector(7 downto 0));
end seven_segment;

architecture selector of seven_segment is
begin
    with input_bin select
        led_out <= "11111100" when "0000",
                   "01100000" when "0001",
                   "11011010" when "0010",
                   "11110010" when "0011",
                   "01100110" when "0100",
                   "10110110" when "0101",
                   "00111110" when "0110",
                   "11100000" when "0111",
                   "11111110" when "1000",
                   "11100110" when "1001",
                   "00000000" when others;
end selector ;
