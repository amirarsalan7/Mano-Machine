library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;


entity ALU is
    port (
        S : in std_logic_vector(3 downto 0);
        cin: std_logic;
        A, B: in std_logic_vector(15 downto 0);
        F: out std_logic_vector(15 downto 0);
        E: out std_logic
    );
end entity ALU;



architecture Behavorial of ALU is

    
    component Arithmatic is
        port (
            A, B: in std_logic_vector(15 downto 0);
            sel: in std_logic_vector(1 downto 0);
            cin: in std_logic;
            
            cout: out std_logic;
            D: out std_logic_vector(15 downto 0)
            );
        end component Arithmatic;
    

    component LOGIC is
        port (
            Sel: in std_logic_vector(1 downto 0);
            A, B: in std_logic_vector(15 downto 0);
            E: out std_logic_vector(15 downto 0)
        );
    end component LOGIC;


    component ShiftLR is
        port (
            Shift_dir: in std_logic;
            A: in std_logic_vector(15 downto 0);
            H: out std_logic_vector(15 downto 0)
        );
    end component ShiftLR;

    component MUX4to1 is
        port (
            input : in std_logic_vector(3 downto 0);
            sel : in std_logic_vector(1 downto 0);
            q : out std_logic
        );
    end component;
        

    signal Arith_val: std_logic_vector(15 downto 0);
    signal logic_val: std_logic_vector(15 downto 0);
    signal shift_val_L: std_logic_vector(15 downto 0);
    signal shift_val_R: std_logic_vector(15 downto 0);

begin
    
    Arithmatic_block: Arithmatic port map(
        A => A,
        B => B,
        sel => S(1 downto 0),
        cin => cin,
        cout => E,
        D => Arith_val
    );

    Logic_block: LOGIC port map(
        Sel => S(1 downto 0),
        A => A,
        B=> B,
        E=> logic_val
    );

    Shift_Right_block: ShiftLR port map(
        Shift_dir => '0',
        A => A,
        H => shift_val_R
    );


    Shift_Left_block: ShiftLR port map(
        Shift_dir => '1',
        A => A,
        H => shift_val_L
    );

    FINAL_VALUE_GEN: for i in 0 to 15 generate  
        Final_value: MUX4to1 port map(
            input(0) => Arith_val(i),
            input(1) => logic_val(i),
            input(2) => shift_val_R(i),
            input(3) => shift_val_L(i),
            sel => S(3 downto 2),
            q => F(i)
        );
    end generate;

    
end architecture Behavorial;


-- ALU: 16-bit Arithmetic and Logic Unit (ALU)
--
--
-- Operation:
--   - The ALU performs arithmetic, logic, and shift operations.
--   - It consists of three main functional blocks:
--       1. Arithmetic block (Arithmatic): Handles addition, subtraction, etc.
--       2. Logic block (LOGIC): Performs bitwise AND, OR, XOR, and NOT.
--       3. Shift block (ShiftLR): Performs left and right logical shifts.
--   - A 4-to-1 multiplexer selects the final output based on the upper two bits of S.
--
-- Control Signals (S[3:0]):
--   S[3:2]  | Operation
--  ------------------------
--      00   | Arithmetic (Add/Sub)
--      01   | Logic (AND, OR, XOR, NOT)
--      10   | Right Shift
--      11   | Left Shift







-- ALU Control Signals and Operations:
--   S[3:2]  | S[1:0] | Operation        | Description                        
--  -------------------------------------------------------------------
--      00   | 00     | Addition         | F = A + B                          
--      00   | 01     | Subtraction      | F = A - B                          
--      00   | 10     | Add with Carry   | F = A + B + cin                    
--      00   | 11     | Sub with Borrow  | F = A - B - cin                    
--      01   | 00     | AND              | F = A AND B                        
--      01   | 01     | OR               | F = A OR B                         
--      01   | 10     | XOR              | F = A XOR B                        
--      01   | 11     | NOT A            | F = NOT A                          
--      10   | XX     | Right Shift      | F = A >> 1 (Logical Shift)         
--      11   | XX     | Left Shift       | F = A << 1 (Logical Shift)         

-- Notes:
-- - 'cin' (carry-in) is only relevant for arithmetic operations.
-- - 'XX' in S[1:0] for shifts means that these bits are ignored.
-- - 'E' (carry-out) is only meaningful for arithmetic operations.
