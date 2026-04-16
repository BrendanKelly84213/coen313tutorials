library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity repeated_div is
    port ( clk, reset, start : in std_logic;
           a, b : in unsigned(7 downto 0);
           ready : out std_logic;
           r_next_high : out integer;
           q, r : out unsigned(7 downto 0));
end repeated_div;

-- psuedo algorithm
-- r = a
-- q = 0
-- while (r >= b) {
--     r -= b
--     q++;
-- } 
-- 

-- r = a
-- q = 0

-- loop:
-- if (r < b ) 
--      goto done;
-- 
-- q = q + 1;
-- r = r - b;
-- if (r >= b)
--     goto loop;
-- 
-- done;
   
architecture behavioural of repeated_div is
    type t_state is (idle, op, done);
    signal state, state_next : t_state;
    signal r_reg, q_reg, r_next, q_next : unsigned(7 downto 0);
    signal r_next_high_bit  : std_logic;
begin

    r_next_high_bit <= r_next(r_next'high);
    -- control path: registers of the FSM
    process(clk, reset)
    begin 
        if (reset = '1') then
            state <= idle;
        elsif (rising_edge(clk)) then
            state <= state_next;
        end if;
    end process;
    -- control path: next state logic
    process(state, start, r_next )
    begin
        state_next <= state;
        case state is
            when idle =>
                if (start = '1') then
                    if (r_next < b or r_next_high_bit = '1') then -- using unsigned don't feel like using integer so detect overflow like this
                        state_next <= done;
                    elsif (r_next >= b) then
                        state_next <= op;
                    end if;
                else 
                    state_next <= idle;
                end if;
            when op =>
                if (r_next < b or r_next_high_bit = '1') then 
                    state_next <= done;
                elsif (r_next >= b) then
                    state_next <= op;
                end if;
            when done =>
                if (start = '1') then -- I guess idea being start is a push button ...
                    state_next <= idle;
                end if;
        end case;
    end process;

    --control path: output logic
    ready <= '1' when state = done else
             '0';

    -- data path: registers used in the data path
    process(clk, reset)
    begin
        if (reset = '1') then
           q_reg <= (others => '0');
           r_reg <= (others => '0');
        elsif (rising_edge(clk)) then
           q_reg <= q_next;
           r_reg <= r_next;
        end if;
    end process;

    -- data path: multiplexers
    process(state, b, q_reg, r_reg)
    begin
        case state is
            when idle =>
                q_next <= (others => '0');
                r_next <= a;
            when op =>
                q_next <= q_reg + 1;  
                r_next <= r_reg - b;
            when done =>
                q_next <= q_reg;
                q_next <= q_reg;
        end case;
    end process;

    -- data path: output
    q <= q_reg;
    r <= r_reg;

end behavioural;
           
