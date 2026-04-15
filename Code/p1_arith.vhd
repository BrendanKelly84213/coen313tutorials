architecture arith_arch of p1 is
    signal mux_out : std_logic_vector(1 downto 0) := (others => '0');
    signal sum3_vec : std_logic_vector(2 downto 0) := (others => '0');
begin
    mux_out <= b when ctrl = '0' else
               not b;

    sum3_vec <= ('0' & mux_out) + ('0' & a) + ("00" & ctrl);
    sum <= sum3_vec(1 downto 0);
    Cout <= sum3_vec(2);

end arith_arch;
