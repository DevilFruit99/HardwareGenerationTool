# HardwareGenerationTool
Tool to generate synthesizable matrix-vector multiplier in System Verilog and its accompanying test bench.

##Top-level module description
###Inputs:
<ul>
<li>clk - clock signal</li>
<li>reset - synchronous reset, only needs to be asserted on first use</li>
<li>loadMatrix - indicates a matrix 'A' needs to be loaded</li>
<li>loadVector - indicates vector 'X' needs to be loaded. Only a matrix or a Vector can be loaded at any given point not both</li>
<li>start - should be asserted to begin matrix-vector multiplication, A.X</li>
<li>data_in[b-1:0] - accepts new data every clock cycle after load is asserted. b (bit width of data) can be set using the hardware generation program </li>
</ul>
###Outputs:
<ul>
<li>data_out[2b-1:0] - outputs one number of the result of matrix multiplication every clock cycle</li>
<li>done - asserted by the module to indicate start of output</li>
</ul>
For instructions of how to run the hardware generation tool see Readme in src directory

For more information on how the tool's function and structure see https://goo.gl/oToCcR
