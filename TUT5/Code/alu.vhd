library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is 
    generic (
        N : integer := 2
    );
         
    port (
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);
        ALU_OP : in std_logic_vector(1 downto 0);
        RESULT : out std_logic_vector(N-1 downto 0);
        COUT : out std_logic
        );
end alu;

architecture behavioural of alu is
begin

    process(A, B, ALU_OP)
        variable c_in : std_logic := '0';
    begin
       c_in := '0';
       COUT <= '0';
       RESULT <= (others => '0');
       if ALU_OP = "00" then -- add
            for i in 0 to N-1 loop
               RESULT(i) <= c_in xor A(i) xor B(i);
               c_in := (A(i) and B(i)) or (A(i) and c_in) or (B(i) and c_in);
            end loop;
        end if;
        COUT <= c_in;
    end process;
end behavioural;
