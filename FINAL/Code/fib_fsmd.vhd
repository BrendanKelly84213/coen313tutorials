library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity fib_fsmd is
    port ( clk, reset, start : std_logic;
           n : in unsigned(4 downto 0);
           ready : out std_logic;
           fib : out unsigned(15 downto 0));
end fib_fsmd;

architecture behavioural of fib_fsmd is
    type t_state is (idle, load, op, done0, done1);
    signal state_reg, state_next : t_state;
    signal i_reg, i_next : unsigned(4 downto 0);
    signal fib0_reg, fib0_next, fib1_reg, fib1_next : unsigned(15 downto 0);
begin
    -- control path state register
    process(clk, reset)
    begin
        if (reset = '1') then
            state_reg <= idle;
        elsif (rising_edge(clk)) then
            state_reg <= state_next;
        end if;
    end process;

    -- control path next state
    process(state_reg, i_next, start)
    begin
        case state_reg is
            when idle => 
                if (start = '1') then
                    state_next <= load;
                else 
                    state_next <= idle;
                end if;
            when load =>
                state_next <= op;
            when op =>
                if (i_next = 0) then
                    state_next <= done0;  
                elsif (i_next = 1) then
                    state_next <= done1;
                else 
                    state_next <= op;
                end if;
            when done0 | done1 =>
                state_next <= idle;
        end case;
    end process;

    -- control path registers
    process(clk, reset)
    begin
        if (reset = '1') then
            i_reg <= (others => '0');
            fib0_reg <= (others => '0');
            fib1_reg <= (others => '0');
        elsif (rising_edge(clk)) then
            i_reg <= i_next;
            fib0_reg <= fib0_next;
            fib1_reg <= fib1_next;
        end if;
    end process;

    -- control path:  output logic
    ready <= '1' when state_reg = done0 or state_reg = done1 else 
             '0';

    -- data path resgisters
    process(state_reg, n, fib1_reg, fib0_reg, i_reg)
    begin
        fib1_next <= fib1_reg; 
        fib0_next <= fib0_reg;
        i_next <= i_reg;
        case state_reg is
            when idle =>
                fib0_next <= fib0_reg;
                fib1_next <= fib1_reg;
                i_next <= i_reg;
            when load =>
                fib0_next <= (others => '0');
                fib1_next <= (0 => '1', others => '0');
                i_next <= n;
            when op => 
                fib1_next <= fib1_reg + fib0_reg;
                fib0_next <= fib1_reg;
                i_next <= i_reg - 1;
            when done0 =>
                fib1_next <= (others => '0');
            when done1 =>
                fib1_next <= fib1_reg; 
                fib0_next <= fib0_reg;
                i_next <= i_reg;
        end case;
    end process;
    
    -- data path output
    fib <= fib1_reg;

end behavioural;
