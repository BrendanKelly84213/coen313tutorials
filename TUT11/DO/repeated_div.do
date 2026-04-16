force clk 0, 1 5 ns -r 10 ns
force reset 1
force start 0
force a "00000101"
force b "00000010"
run 10 ns

force reset 0
run 10 ns

force start 1
run 10 ns
