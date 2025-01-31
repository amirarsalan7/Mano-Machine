library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity SR is
    port (
        S,R: in std_logic;
        Q: inout std_logic
    );
end entity SR;

architecture behavorial of SR is
    signal notQ: std_logic := '0';
begin

    Q <= R nor notQ;
    notQ <= S nor Q;
    
    
end architecture behavorial;