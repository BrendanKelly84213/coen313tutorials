library ieee ;
use ieee.Std_logic_1164.all ;

entity manchester_encoder is
    port ( clk , reset: in std_logic;
           v,d: in std_logic;
           y: out std_logic);
end manchester_encoder;

architecture moore_arch of manchester_encoder is
    type t_state is (idle, s1a, s1b, s0a, s0b);
    signal state, state_next : t_state;
    signal y_reg, y_next : std_logic;
begin

    -- control path: FSM state register
    process(clk, reset)
    begin
        if (reset = '1') then
            state <= idle;
        elsif (rising_edge(clk)) then
            state <= state_next;
        end if;
    end process;

    -- control path: next state logic
    process(state, v, d)
    begin
        state <= state_next;
        case state is
            when idle =>
                if (v = '0') then 
                    state_next = idle;
                elsif (d = '1') then
                    state_next <= s1a;
                else 
                    state_next <= s0a;
                end if;
            when s1a =>
                state_next <= s1b;
            when s1b =>
                if (v = '0') then 
                    state_next <= idle;
                elsif (d = '1') then 
                    state_next <= s1a;
                else 
                    state_next <= s0a;
                end if;
            when s0a =>
                state_next <= s0b;
            when s0b =>
                if (v = '0') then
                    state_next <= idle;
                elsif (d = '1') then 
                    state_next <= s1a;
                else 
                    state_next <= s0a;
                end if;
            when others =>
                state_next <= idle
        end case;
    end process;

    -- control path: registers
    process(clk, reset) 
    begin
        if (reset = '1') then
            y_reg <= '0';
        elsif (rising_edge(clk)) then
            y_reg <= y_next;
        end if;
    end process;

    -- data path: registers
    process(state, v, d)
    begin
        case state is
            when s1a =>
                y_next <= '1';    
            when s0b =>
                y_next <= '1';
            when others =>
                y_next <= '0';
        end case;
    end process;

    y <= y_reg;
end moore_arch;
