add wave *
force clk 0,1 5 ns -r 10 ns
force n 00110
force reset 1
force start 0
run 10 ns
force reset 0
force start 1
run 10 ns
force start 0
run 10 ns
