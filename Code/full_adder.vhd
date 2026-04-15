library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity full_adder is 
    port (a : in std_logic;
          b : in std_logic;
          c_in : in std_logic;
          c_out : out std_logic;
          sum : out std_logic);
end full_adder;

-- a b ci s c_out
-- 0 0 0  0 0  
-- 0 0 1  1 0
-- 0 1 0  1 0 
-- 0 1 1  0 1
-- 1 0 0  1 0
-- 1 0 1  0 1
-- 1 1 0  0 1
-- 1 1 1  1 1

-- ci\ab
--    00 01 11 10
-- 0   0  0  1  0  
-- 1   0  1  1  1

-- cib + ab + cia

architecture behavioural of full_adder is
begin
    sum <= c_in xor a xor b;
    c_out <= (c_in and b) or (a and b) or (c_in and a);
end behavioural;

