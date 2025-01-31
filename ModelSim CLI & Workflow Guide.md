# ModelSim CLI & Workflow Guide

## 1. Compilation & Simulation

### Compile VHDL/Verilog
```sh
vcom design.vhd        # Compile VHDL file
vlog design.v          # Compile Verilog file
vcom -refresh          # Recompile all files
vcom */*.vhd           # Compile  all files
```

### Simulate Design
```sh
vsim work.<entity>                        # Load entity (e.g., vsim work.FullAdder)
vsim -c -wlf <path> work.<entity>         # -c: cli / -wlf : save waveform
run 100ns                                 # Run for 100ns
run -all                                  # Run until completion
restart -force                            # Restart simulation
quit -force                               # Exit ModelSim
# or simply run the do file in the waves folder
do wave/<filename>.do
```

## 2. Waveform Debugging

### Add Signals to Waveform
```sh
add wave *             # Add all signals to waveform
add wave A B Cin       # Add specific signals
```

### Force Signal Values
```sh
force  A 1 0ns  # Force A=1 at 0ns
force  B 0 50ns # Force B=0 at 50ns

force a 0 0, 1 10 -repeat 20;  # Force A=0 at 0ns A=1 at 20ns A=0 in 20ns cycles 
```

### Basic Value Inspection
```sh
examine A        # Check value of signal A in the "dut" hierarchy
examine sim:/tb/clk   # Check clock signal in testben
examine {A B} # Check values of A and B
```

### View and Save Waveforms
```sh
wave zoom full         # Zoom out to full view
wave save wave.do      # Save waveform configuration
```

## 3. Project Management

### Create/Open Projects
```sh
project new . my_project    # Create a new project
project open my_project.mpf # Open an existing project
project addfile design.vhd  # Add a file to the project
```

### Remove Files from Project
```sh
project removefile design.vhd  # Remove a file from the project
project close               # closing the current project
```

### Save and Close Project
```sh
project save                 # Save project
project close                # Close project
```

## 4. Automation with TCL Scripts

### Example script (script.do)
```tcl
vcom design.vhd
vsim work.entity
add wave *
run -all
quit
```

### Run the script
```sh
vsim -c -do script.do
```

### Automating with Batch Mode
```sh
vsim -c -do "vcom design.vhd; vsim work.entity; run -all; quit"
```

## 5. Advanced ModelSim CLI Usage

### Logging & Debugging
```sh
log -r /*              # Log all signals
log -r /tb/*          # Log signals within a testbench
```

### Checking Active Processes
```sh
info objects          # List active objects
info wave             # List signals in waveform window
```

### Exporting Results
```sh
write list mylist.lst # Export list of signals
write wave mywave.wlf # Save waveform file
```

### Interactive Signal Inspection
```sh
examine /dut/A        # Inspect value of signal A
examine -radix hex /dut/B # Inspect value of B in hex
```

### Conditional Breakpoints
```sh
when { /dut/clk = '1' } { echo "Clock tick detected" }
```

## 6. Key Commands Cheat Sheet

| Task           | Command                           |
|---------------|-----------------------------------|
| Compile VHDL  | `vcom design.vhd`                |
| Compile Verilog | `vlog design.v`                |
| Simulate      | `vsim work.entity`               |
| Force Signal  | `force -freeze /dut/signal 1 0ns`|
| Run & Quit    | `vsim -c -do "run -all; quit"`   |
| Save Waveform | `wave save wave.do`              |
| Remove File   | `project removefile design.vhd`  |
| Save Project  | `project save`                   |
| Close Project | `project close`                  |
| Log Signals   | `log -r /*`                      |
| Inspect Signal | `examine /dut/A`                |
| Conditional Break | `when { condition } { command }` |

---
For more information, visit: [ModelSim Documentation](https://eda.sw.siemens.com/en-US/ic/modelsim/)

