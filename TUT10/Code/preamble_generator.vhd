library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity preamble_generator is
    port( clk, reset, start : in std_logic;
          data_out : out std_logic);
end preamble_generator;

architecture behavioural of preamble_generator is
    constant idle : std_logic_vector(3 downto 0) := "0000";
    constant s1   : std_logic_vector(3 downto 0) := "0010"; -- 2
    constant s2   : std_logic_vector(3 downto 0) := "0001"; -- 1
    constant s3   : std_logic_vector(3 downto 0) := "0100"; -- 4 
    constant s4   : std_logic_vector(3 downto 0) := "0011"; -- 3
    constant s5   : std_logic_vector(3 downto 0) := "0110"; -- 6
    constant s6   : std_logic_vector(3 downto 0) := "0101"; -- 5
    constant s7   : std_logic_vector(3 downto 0) := "1000"; -- 8
    constant s8   : std_logic_vector(3 downto 0) := "0111"; -- 7

    signal state : std_logic_vector(3 downto 0);
    signal next_state : std_logic_vector(3 downto 0);
begin
    process(clk) 
    begin 
        if (rising_edge(clk)) then
            if (reset = '1') then
                state <= idle;
            else 
                state <= next_state;
            end if;
        end if;
    end process;

    process(state, start)
    begin 
        next_state <= state;
        case state is
            when idle =>
                next_state <= s1;
            when s1 =>
                next_state <= s2;
            when s2 =>
                next_state <= s3;
            when s3 =>
                next_state <= s4;
            when s4 =>
                next_state <= s5;
            when s5 =>
                next_state <= s6;
            when s6 =>
                next_state <= s7;
            when s7 =>
                next_state <= s8;
            when s8 =>
                next_state <= idle;
            when others =>
                next_state <= idle;
        end case;

    end process;

    data_out <= state(0);
end behavioural;
