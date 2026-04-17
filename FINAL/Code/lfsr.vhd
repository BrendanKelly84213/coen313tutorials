library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
    port( clk, reset: in std_logic;
          error_sig: out std_logic;
          q: out std_logic_vector(6 downto 0));
end lfsr;
--your code here

architecture behavioural of lfsr is
    signal q_reg : std_logic_vector(6 downto 0);
    signal q_next : std_logic_vector(6 downto 0);
begin 

    process(clk, reset)
    begin 
        if (reset = '1') then
            q_reg <= "0000001";        
            error_sig <= '0';
        elsif (rising_edge(clk)) then
            if (q_next = "0000000") then
                error_sig <= '1';
                q_reg <= "0000001";
            else
                q_reg <= q_next; 
            end if;
        end if;
    end process;
    
    q_next <= q_reg(5 downto 0) & q_reg(3) xor q_reg(0);

    q <= q_reg;
end behavioural;

