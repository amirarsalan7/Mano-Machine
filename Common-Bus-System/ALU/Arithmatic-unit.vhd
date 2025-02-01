library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity Arithmatic is
    port (
        A, B: in std_logic_vector(15 downto 0);
        sel: in std_logic_vector(1 downto 0);
        cin: in std_logic;

        cout: out std_logic;
        D: out std_logic_vector(15 downto 0)
    );
end entity Arithmatic;


architecture Behavorial of Arithmatic is

    component FullAdder is
        port (
            cin, A, B : in std_logic;
            cout, S : out std_logic 
        );
    end component;

    component MUX4to1 is
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;

    signal NOTB: std_logic_vector(15 downto 0);

    signal mux_output: std_logic_vector(15 downto 0);
    signal carry: std_logic_vector(16 downto 0);
begin
    

    NOTB <= NOT B;
    carry(0) <= cin;
    cout <= carry(16);

    GEN_MUX: for i in 0 to 15 generate
        MUX: MUX4to1 port map(
            input(0) => B(i),
            input(1) => NOTB(i),
            input(2) => '0',
            input(3) => '1',
            sel => sel,
            q => mux_output(i)
        );
    end generate;


    GEN_FA: for i in 0 to 15 generate
    FA: FullAdder port map(
        cin => carry(i),
        A => A(i),
        B => mux_output(i),
        cout => carry(i+1),
        S => D(i)
    );
    end generate;



end architecture Behavorial;


-- LOGIC: 16-bit logical unit using 1-bit logicX1 components.
--
--
-- Operation:
--   The design instantiates 16 instances of logicX1, applying the selected
--   logical operation on corresponding bits of A and B.
--
-- The logicX1 component performs a 1-bit logical operation based on Sel:
--
-- Truth Table (for each bit operation):
--   Sel  |  Operation   | ei (Output)
--  -------------------------------
--   "00" |  A AND B    | A AND B
--   "01" |  A OR B     | A OR B
--   "10" |  A XOR B    | A XOR B
--   "11" |  NOT A      | NOT A
--
-- Since this logic is applied to all 16 bits, the entire A and B vectors
-- undergo the selected operation bitwise.
