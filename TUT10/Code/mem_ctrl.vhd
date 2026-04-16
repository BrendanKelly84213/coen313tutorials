library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mem_ctrl_fsm is
    port (clk, reset, mem, rw, burst : in std_logic;
          we_me, we, oe : out std_logic);
end mem_ctrl_fsm;

architecture behavioural of mem_ctrl_fsm is
    type t_state is (idle, read1, read2, read3, read4, write);
    signal state : t_state;
    signal next_state : t_state;
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

    process(state, mem, rw, burst)
    begin
        next_state <= state;
        we_me <= '0';
        we <= '0';
        oe <= '0';
        case state is
            when idle =>
                if (mem = '0') then
                    next_state <= idle;
                elsif (rw = '0') then
                    we_me <= '1';
                    next_state <= write;
                elsif (rw = '1') then
                    next_state <= read1;
                end if;
            when write =>
                we <= '1';
                if (mem = '0') then 
                    next_state <= idle;
                elsif (rw = '1') then
                    next_state <= read1;
                elsif (rw = '0') then
                    next_state <= write;
                end if;
            when read1 =>
                oe <= '1';
                if (burst = '0') then 
                    next_state <= idle;
                else
                    next_state <= read2;
                end if;
            when read2 =>
                oe <= '1';
                next_state <= read3;
            when read3 =>
                oe <= '1';
                next_state <= read4;
            when read4 => 
                oe <= '1';
                if (mem = '0') then
                    next_state <= idle;
                elsif (rw ='1') then
                    next_state <= read1;
                elsif (rw = '0') then
                    we_me <= '1';
                    next_state <= write;
                end if;
            when others => 
                next_state <= idle;
        end case;
    end process;
end behavioural;
