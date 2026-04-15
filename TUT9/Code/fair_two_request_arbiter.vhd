library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity fair_two_request_arbiter is
    port( clk, reset, r0, r1: in std_logic;
          g0, g1 : out std_logic); 
end fair_two_request_arbiter;

architecture behavioural of fair_two_request_arbiter is
    type t_state is (waitr0, waitr1, grant0, grant1);
    attribute enum_encoding : string;
    attribute enum_encoding of t_state : type is "00 01 10 11";
    signal state : t_state;
    signal next_state : t_state;
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if reset = '1' then
                state <= waitr0;
                g0 <= '0';
                g1 <= '0';
            else 
                state <= next_state;
            end if;
        end if;
    end process;

    process(state, r0, r1)
    begin 
        next_state <= state;
        g0 <= '0';
        g1 <= '0';
        case state is
            when waitr1 =>
                if (r1 = '0' and r0 = '0') then 
                    next_state <= waitr1;
                elsif (r1 = '0' and r0 = '1') then
                    next_state <= grant0;
                elsif (r1 = '1') then 
                    next_state <= grant1;
                end if;
            when waitr0 =>
                if (r1 = '0' and r0 = '0') then 
                    next_state <= waitr0;
                elsif (r1 = '1' and r0 = '0') then
                    next_state  <= grant1;
                elsif (r0 = '1') then 
                    next_state <= grant0;
                end if;
            when grant1 =>
                g1 <= '1';
                if (r1 = '1') then
                    next_state <= grant1;
                else
                    next_state <= waitr0;
                end if;
            when grant0 =>
                g0 <= '1';
                if (r0 = '1') then
                    next_state <= grant0;
                else 
                    next_state <= waitr1;
                end if;
        end case;
    end process;
    
end behavioural;
