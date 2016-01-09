// Example output, with parameters k=16, p=1, b=8, g=1

module mvm_16_1_8_1 (clk, reset,loadMatrix,loadVector,start,done,data_in,data_out);

parameter k=16,p=1,b=8,g=1,log_memX=4,log_memA=8;
input   clk,reset,start,loadMatrix,loadVector;
output  done;
input  signed [b-1:0]data_in;
output logic signed [2*b-1:0]data_out;
logic [log_memX-1:0]addr_x, addr_y;
logic [log_memA-1:0]addr_a;
logic wr_en_a,wr_en_x,wr_en_y,clear_acc;
logic [3:0]state; 
 module_control #(log_memX,log_memA, k,p,b,g) ctrl_path(.clk(clk), .start(start), .reset(reset),.loadMatrix(loadMatrix),.loadVector(loadVector),.addr_x(addr_x),.wr_en_x(wr_en_x),
.addr_a(addr_a),.wr_en_a(wr_en_a),
.addr_y(addr_y),.wr_en_y(wr_en_y),
.clear_acc(clear_acc),.done(done));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(addr_y),
.wr_en_a(wr_en_a),.addr_a(addr_a),
.data_in(data_in),.data_out(data_out));
endmodule


module module_mem(clk,addr,wr_en,data_in,data_out);
parameter WIDTH = 16, SIZE = 64,LOG_SIZE = 6;
input logic wr_en,clk;
input logic signed [WIDTH-1:0] data_in;
input logic [LOG_SIZE-1:0] addr;
output logic signed [WIDTH-1:0] data_out;
logic [SIZE-1:0][WIDTH-1:0] mem;
always_ff @(posedge clk)begin
data_out <= mem[addr];//read
if(wr_en)//write
mem[addr]<=data_in;
end
endmodule

 module module_datapath(
clk,clear_acc,
addr_x,wr_en_x,
wr_en_y,addr_y,
wr_en_a,addr_a,
data_in,data_out
);
parameter width = 8,vec_size=3,log_memA=4,log_memX=2,p=1,g=1;

input signed [width-1:0] data_in;
input logic wr_en_x,wr_en_y,wr_en_a,clear_acc,clk;
input [log_memX-1:0]addr_x;
input [log_memA-1:0]addr_a;
input [log_memX-1:0]addr_y;
output logic signed[2*width-1:0] data_out;
logic signed[width-1:0]x_sig,a_sig;
logic signed[2*width-1:0]mult_sig,mult_r_sig,add_sig,add_r_sig;

//instantiating memory modules as needed in Fig. 6

module_mem #(width,(vec_size), log_memX) memX (.clk(clk),.addr(addr_x),.wr_en(wr_en_x),.data_in(data_in),.data_out(x_sig));
module_mem #(width,(vec_size*vec_size), log_memA) memA (.clk(clk),.addr(addr_a),.wr_en(wr_en_a),.data_in(data_in),.data_out(a_sig));
module_mem #(2*width,(vec_size), log_memX) memY (.clk(clk),.addr(addr_y),.wr_en(wr_en_y),.data_in(add_r_sig),.data_out(data_out));

always_comb begin
mult_sig = x_sig * a_sig;//multiplier of Fig. 6
add_sig = mult_r_sig+add_r_sig;//adder of Fig. 6
end
always_ff @(posedge clk)begin
if(clear_acc==1)begin
add_r_sig <=0;
mult_r_sig<=0;
end
else begin
add_r_sig <= add_sig;
mult_r_sig<=mult_sig;
end
end
endmodule


///////////////////////////////////////////////////////////////////
//Module: module_control
//Description: the main module that handles the control needed in our system (control part of reg. transfer desc.)
///////////////////////////////////////////////////////////////////
module module_control(
clk, start, reset,
loadMatrix,loadVector,
addr_x,wr_en_x,
wr_en_y,
clear_acc,done,
addr_a,wr_en_a,
addr_y
);
parameter log_memX=2, log_memA=4, k = 4,p=1,b=8,g=0;
input clk, start, reset,loadMatrix,loadVector;
output logic wr_en_x,wr_en_y;
output logic [log_memX-1:0]addr_x;
output logic done, clear_acc;
output logic wr_en_a;
output logic [log_memX-1:0] addr_y;
output logic [log_memA-1:0]addr_a;
logic [3:0] state;
logic [k:0] i,j,r,q;
//state changing always ff block
always_ff @(posedge clk) begin
//to prevent waiting for one clock cycle doing the work in a state we have included the code for execution at the instant we change state.
//If youre in state 0 or if reset is asserted, move to state 1 and execute its commands
if(reset==1)begin
state<=1;
addr_x<=0;
wr_en_x<=0;
addr_y<=0;
wr_en_a<=0;
addr_y<=0;
addr_a<=0;
wr_en_y<=0;
clear_acc<=0;
done<=0;
i<=0;j<=0;r<=0;q<=0;
end
else begin
if(loadMatrix==1) begin
addr_x<=0;
wr_en_x<=0;
state<=2;
wr_en_a<=1;
addr_a <= 0;
i<=0;
end
else if(state==2&&i<k*k)begin
addr_a<=i+1;
i<=i+1;
if(i==k*k-1)begin
wr_en_a<=0;
end
end
 if(loadVector==1)begin
state<=3;
addr_x<=0;
wr_en_x<=1;
addr_a<=0;
wr_en_a<=0;
i<=0;
end
else if (state ==3 && j<k)begin
addr_x<=j+1;
j<=j+1;
if(j==k-1)begin
wr_en_x<=0;
end
end
 if(start==1)begin //cleares the flipflop and initiates memory addresses to start MAC operation
state<=4;
addr_x<=0;
wr_en_x<=0;
addr_a<=0;
wr_en_a<=0;
clear_acc<=1;
j<=1;
i<=1;
end
else if(state==4 || (state==5 && j<k))begin //start reading from matrix A and vector X
state<=5;
clear_acc<=0;
addr_x<=j;
addr_a<=i;
i<=i+1;
j<=j+1;
q<=0;
end
else if(state==5&&j==k)begin//wait in state 6 for output of MAC
state<=6;
j<=0;
if(g==1)
q<=q+1;
end
else if(state==6&&q==1)begin
state<=6;
q<=q+1;
clear_acc<=0;
end
else if(state==6)begin//writes into memory Y
state<=7;
addr_x<=j;
addr_y<=i/k-1;
wr_en_y<=1;
clear_acc<=0;
end
else if(state==7)begin
if(i<k*k)begin
state<=5;//go to five in next state
addr_x<=j;
addr_a<=i;
i<=i+1;
j<=j+1;
wr_en_y<=0;
clear_acc<=1;
end
else if(i==k*k)begin
state<=8;//go to state 8 to start outputting y values
r<=r+1;
done<=1;//assert done signal
addr_y<=r;
wr_en_y<=0;
end
end
else if(state==8)begin//reads from memory Y
state<=9;
done<=0;
addr_y<=r;
r<=r+1;
end
else if(state==9&&r<k)begin
addr_y<=r;
r<=r+1;
end
else if(r==k)begin //return to state 1 after completing work in state 9
state<=1;
addr_x<=0;
wr_en_x<=0;
wr_en_y<=0;
clear_acc<=0;
done<=0;
i<=0;j<=0;q<=0;r<=0;
wr_en_a<=0;
addr_a<=0;
end
end
end
endmodule

