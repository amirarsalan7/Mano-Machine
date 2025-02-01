library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity MUX2to1 is
    port (
        input : in std_logic_vector(1 downto 0);
        sel : in std_logic;
        q : out std_logic
    );
end entity MUX2to1;

architecture Behavorial of MUX2to1 is
    
begin



    q <= (input(0) and (NOT sel)) or (input(1) and sel);
    
end architecture Behavorial;