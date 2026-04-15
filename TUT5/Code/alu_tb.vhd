library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture behavioural of alu_tb is
    component alu
        generic(
            N : integer
        );
        port (
            A : in std_logic_vector(N-1 downto 0);
            B : in std_logic_vector(N-1 downto 0);
            ALU_OP : in std_logic_vector(1 downto 0);
            RESULT : out std_logic_vector(N-1 downto 0);
            COUT : out std_logic
            );
    end component;

    signal A2bit : std_logic_vector(1 downto 0);
    signal B2bit : std_logic_vector(1 downto 0);
    signal RES2bit : std_logic_vector(1 downto 0) := (others => '0');
    signal COUT2bit : std_logic := '0';
begin
    i_alu2bitadd : alu
        generic map(
            N => 2
        )
        port map(
            A => A2bit,
            B => B2bit,
            ALU_OP => "00",
            RESULT => RES2bit,
            COUT => COUT2bit
        );
        
    process
    begin 
        A2bit <= "00";
        B2bit <= "00";
        wait for 10 ns;
        A2bit <= "11";
        B2bit <= "01";
        wait for 10 ns;
        A2bit <= "00";
        B2bit <= "00";
        wait for 10 ns;
        A2bit <= "01";
        B2bit <= "01";
        wait for 10 ns;
        A2bit <= "01";
        B2bit <= "10";
        wait for 10 ns;
        A2bit <= "10";
        B2bit <= "10";
        wait for 10 ns;
        A2bit <= "10";
        B2bit <= "11";
        wait for 10 ns;
        A2bit <= "11";
        B2bit <= "10";
        wait for 10 ns;
        A2bit <= "11";
        B2bit <= "11";
        wait for 10 ns;
        assert false report "Test: OK" severity failure;
    end process;

end behavioural;
