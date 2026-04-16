library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity sequence_detector is
    port ( clk, reset, x : in std_logic;
           z : out std_logic);
end sequence_detector;

architecture behavioural of sequence_detector is
    type t_state is (b3, b2, b1, b0);
    signal state, next_state : t_state;
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                state <= b3;
            else
                state <= next_state;
            end if;
        end if;
    end process;

    process(state, x)
    begin
        next_state <= state;
        z <= '0';
        case state is
            when b3 =>
                if (x = '1') then
                    next_state <= b2;
                else 
                    next_state <= b3;
                end if;
            when b2 =>
                if (x = '1') then
                    next_state <= b1;
                else 
                    next_state <= b3;
                end if;
            when b1 =>
                if (x = '0') then
                    next_state <= b0;
                else 
                    next_state <= b3;
                end if;
            when b0 =>
                if (x = '1') then
                    z <= '1';
                    next_state <= b2; -- skip the first bit for overlap
                else 
                    next_state <= b3;
                end if;
            when others =>
                next_state <= b3;
        end case;
    end process;
end behavioural;
