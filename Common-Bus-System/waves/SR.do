vcom RAM/Set-reset-latch.vhd
vsim work.SR
add wave *

force S 0 0, 1 10 -repeat 20
force R 0 0, 1 20 -repeat 40

run 40