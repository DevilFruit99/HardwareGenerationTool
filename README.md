### HardwareGenerationTool
Tool to generate synthesizable matrix-vector multiplier in System Verilog and its accompanying test bench.

##Top-level module description
#Inputs:
clk - clock signal
reset - synchronous reset, only needs to be asserted on first use
loadMatrix - indicates a matrix 'A' needs to be loaded
loadVector - indicates vector 'X' needs to be loaded. Only a matrix or a Vector can be loaded at any given point not both
start - should be asserted to begin matrix-vector multiplication, A.X
data_in[b-1:0] - accepts new data every clock cycle after load is asserted. b (bit width of data) can be set using the hardware generation program 

#Outputs:
data_out[2b-1:0] - outputs one number of the result of matrix multiplication every clock cycle
done - asserted by the module to indicate start of output

For more instructions of how to run the hardware generation tool see Readme in src directory
