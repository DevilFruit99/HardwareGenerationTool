`include "p_vyas_mvm_8_8_8_1.sv"
///////////////////////////////////////////////////////////////////
//Module: tbench
///////////////////////////////////////////////////////////////////
module tbench();
parameter k =8,b = 8,test_size=1000,period=10,latency=1500*period,
data_matrix = k*k,
data_vector = k,
data_len = 56183;
logic clk,reset,start;
logic loadMatrix,loadVector;
logic  done;
logic signed [b-1:0]data_in;
logic  signed [2*b-1:0]data_out;
initial clk=0;
always #(period/2) clk=~clk;
mvm_8_8_8_1 dut(clk,reset,loadMatrix,loadVector,start,done,data_in,data_out);
logic [b-1:0] testData[data_len:0];
integer line_pos;//line_pos shows where the mode value is for an iteration
initial $readmemh("refData_8_8_8_1.mem", testData);
integer l,q;
integer i,mode,jump;
int j;
initial begin
#1;
l<=0;
line_pos=0;
q<=k;
reset = 1;
#period;
reset = 0;
for (i=0; i<test_size; i=i+1) begin
mode = testData[line_pos];
//assign a value for jump
if(mode == 1||mode == 2)
jump = data_matrix+data_vector;
else if(mode == 3)
jump = data_matrix;
else if(mode == 4)
jump = data_vector;
#1;
//assert load Matrix and load Vector according to mode
if(mode==1)begin
loadMatrix = 1;
#period;
loadMatrix=0;
for (j=line_pos+1;j<=line_pos+data_matrix+1;j=j+1)/*(j=i*(data_matrix)+i*q;j<(i+1)*data_matrix+i*q;j=j+1)*/begin
data_in = testData[j];
#period;
end
#(period*(j % 10));
loadVector = 1;
#period;
loadVector = 0;
for (j=line_pos+data_matrix+1;j<=line_pos+jump;j=j+1)/*(j=(i+1)*data_matrix+i*q;j<(i+1)*data_matrix+data_vector+i*q;j=j+1)*/begin
data_in = testData[j];
#period ;
end
end
else if(mode==2)begin	
loadVector = 1;
#period;
loadVector = 0;
for (j=line_pos+1;j<=line_pos+data_vector;j=j+1)/*(j=(i+1)*data_matrix+i*q;j<(i+1)*data_matrix+data_vector+i*q;j=j+1)*/begin
data_in = testData[j];
#period ;
end
#(period*(j % 10));
loadMatrix = 1;
#period;
loadMatrix=0;
for (j=line_pos+data_vector+1;j<=line_pos+jump;j=j+1)/*(j=i*(data_matrix)+i*q;j<(i+1)*data_matrix+i*q;j=j+1)*/begin
data_in = testData[j];
#period ;
end
end
else if(mode==3)begin
loadMatrix = 1;
#period;
loadMatrix = 0;
for (j=line_pos+1;j<=line_pos+jump;j=j+1)begin
data_in = testData[j];
#period ;
end
end
else if(mode==4)begin
loadVector = 1;
#period;
loadVector = 0;
for (j=line_pos+1;j<=line_pos+jump;j=j+1)begin
data_in = testData[j];
#period ;
end
end
#(period*(j % 10));
start = 1;
#period;
start=0;
@(posedge done)#(period*(data_vector+1));
line_pos=line_pos+jump+1;//go to the line with the next mode value
#(period*((j*3) % 10));
end
#period;//wait for a couple of cycles to finish writing to outValues;
#period;
$fclose(filehandle);
$finish;
end
integer filehandle=$fopen("outValues_8_8_8_1");
//This writes the outputs to outValues when the done signal is asserted
always @(posedge clk)begin
if(done==1)begin
l<=1;
end
if(l>=1 && l<=k)begin
$fdisplay(filehandle, "%d",data_out);
l<=l+1;
if(l==k)begin
$fdisplay(filehandle,"---");
l<=0;
end
end
end
endmodule
