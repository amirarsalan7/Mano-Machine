library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity FullAdder is
    port (
        cin, A, B : in std_logic;
        cout, S : out std_logic 
    );
end entity FullAdder;

architecture Behavorial of FullAdder is
    
begin
    
    S <= A xor B xor cin;
    
    cout <= ((A xor B) and cin) or (A and B);
    
    -- Alternate form
    -- Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin); 
    
    
end architecture Behavorial;