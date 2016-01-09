`include "p_vyas_mvm_32_32_8_1.sv"
module throughput_gen();
parameter k=32,b=32,log_memA=10,log_memx=5;
logic [b-1:0] data_in;
logic [k*k-1:0]j;
logic loadm,loadv,reset,start,done;
int period =10,c;
bit clk;

always begin
clk=~clk;
#period;
end

mvm_32_32_8_1 dut(clk,reset,loadm,loadv,start,done,data_in/*,data_out*/);

initial begin
#1;reset=1;
#period;reset=0;

//enter k*k data words into matrix
loadm=1;
#period;loadm=0;
for(j=0;j<k*k;j++)begin
data_in = j;
#period;
end
//load k cycles with vector
loadv=1;
#period;
loadv=0;
for(j=0;j<k;j++)begin
data_in = 1;
#period;
end

//start 
start=1;
#period;
start=0;

end

always @(posedge clk)begin
if(loadv==1)begin
c=1;
end
else if(loadv==0)begin
c+=1;
end
if(done)begin
$display("c=%d\nk/c=%d",c,k/c);
$finish;
end
end

endmodule