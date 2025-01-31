library IEEE;
use IEEE.std_logic_1164.all;
-- use IEEE.numeric_std.all;

entity DEC4to16 is
    port (
        W: in std_logic_vector(3 downto 0);
        Y: out std_logic_vector(15 downto 0);
        enable: in std_logic
    );
end entity DEC4to16;


architecture Behavorial of DEC4to16 is
    component DEC2to4 is
        port (
            W: in std_logic_vector(1 downto 0);
            Y: out std_logic_vector(3 downto 0);
            enable: in std_logic
        );
    end component;
    signal mid_sig: std_logic_vector(3 downto 0);
begin
    

    firsr_layer : DEC2to4 port map (
        w(0) => w(2),
        w(1) => w(3),
        Y => mid_sig,
        enable => enable
    );


    --using for generate for simplicity and code readebility
    second_layer_GEN : for i in 0 to 3 generate
        DEC_GEN : DEC2to4 port map (
            w(0) => w(0),
            w(1) => w(1),
            Y => Y((4*i+3) downto 4*i),
            enable =>  mid_sig(i)
        );      
    end generate;


    -- port map normally
    -- DEC1: DEC2to4 port map (
    --     w(0) => w(0),
    --     w(1) => w(1),
    --     Y => Y(3 downto 0),
    --     enable =>  mid_sig(0)
    -- );

    -- DEC2: DEC2to4 port map (
    --     w(0) => w(0),
    --     w(1) => w(1),
    --     Y => Y(7 downto 4),
    --     enable =>  mid_sig(1)
    -- );

    -- DEC3: DEC2to4 port map (
    --     w(0) => w(0),
    --     w(1) => w(1),
    --     Y => Y(11 downto 8),
    --     enable =>  mid_sig(2)
    -- );

    -- DEC4: DEC2to4 port map (
    --     w(0) => w(0),
    --     w(1) => w(1),
    --     Y => Y(15 downto 12),
    --     enable =>  mid_sig(3)
    -- );
    
end architecture Behavorial;