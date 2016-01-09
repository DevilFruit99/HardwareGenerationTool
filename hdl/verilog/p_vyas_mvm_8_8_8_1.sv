// Example output, with parameters k=8, p=8, b=8, g=1

module mvm_8_8_8_1 (clk, reset,loadMatrix,loadVector,start,done,data_in,data_out);

parameter k=8,p=8,b=8,g=1,log_memX=3,log_memA=6;
input   clk,reset,start,loadMatrix,loadVector;
output  done;
input  signed [b-1:0]data_in;
output logic signed [2*b-1:0]data_out;
logic [log_memX-1:0]addr_x, sel_y;
logic [3:0]state; 
 logic wr_en_x,wr_en_y,clear_acc;logic [log_memX-1:0]addr_a1;
logic signed [2*b-1:0] out_y1;
logic wr_en_a1;
logic [log_memX-1:0]addr_a2;
logic signed [2*b-1:0] out_y2;
logic wr_en_a2;
logic [log_memX-1:0]addr_a3;
logic signed [2*b-1:0] out_y3;
logic wr_en_a3;
logic [log_memX-1:0]addr_a4;
logic signed [2*b-1:0] out_y4;
logic wr_en_a4;
logic [log_memX-1:0]addr_a5;
logic signed [2*b-1:0] out_y5;
logic wr_en_a5;
logic [log_memX-1:0]addr_a6;
logic signed [2*b-1:0] out_y6;
logic wr_en_a6;
logic [log_memX-1:0]addr_a7;
logic signed [2*b-1:0] out_y7;
logic wr_en_a7;
logic [log_memX-1:0]addr_a8;
logic signed [2*b-1:0] out_y8;
logic wr_en_a8;
module_control #(log_memX,log_memA, k,p,b,g) ctrl_path(.clk(clk), .start(start), .reset(reset),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.sel_y(sel_y),.loadMatrix(loadMatrix),.loadVector(loadVector),
.clear_acc(clear_acc),
.addr_a1(addr_a1),
.wr_en_a1(wr_en_a1),
.addr_a2(addr_a2),
.wr_en_a2(wr_en_a2),
.addr_a3(addr_a3),
.wr_en_a3(wr_en_a3),
.addr_a4(addr_a4),
.wr_en_a4(wr_en_a4),
.addr_a5(addr_a5),
.wr_en_a5(wr_en_a5),
.addr_a6(addr_a6),
.wr_en_a6(wr_en_a6),
.addr_a7(addr_a7),
.wr_en_a7(wr_en_a7),
.addr_a8(addr_a8),
.wr_en_a8(wr_en_a8),
.done(done));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path1(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a1),.addr_a(addr_a1),
.data_in(data_in),.data_out(out_y1));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path2(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a2),.addr_a(addr_a2),
.data_in(data_in),.data_out(out_y2));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path3(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a3),.addr_a(addr_a3),
.data_in(data_in),.data_out(out_y3));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path4(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a4),.addr_a(addr_a4),
.data_in(data_in),.data_out(out_y4));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path5(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a5),.addr_a(addr_a5),
.data_in(data_in),.data_out(out_y5));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path6(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a6),.addr_a(addr_a6),
.data_in(data_in),.data_out(out_y6));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path7(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a7),.addr_a(addr_a7),
.data_in(data_in),.data_out(out_y7));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path8(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a8),.addr_a(addr_a8),
.data_in(data_in),.data_out(out_y8));
always_comb begin
if(sel_y==0)
data_out=out_y1;
else if(sel_y==1)
data_out=out_y2;
else if(sel_y==2)
data_out=out_y3;
else if(sel_y==3)
data_out=out_y4;
else if(sel_y==4)
data_out=out_y5;
else if(sel_y==5)
data_out=out_y6;
else if(sel_y==6)
data_out=out_y7;
else if(sel_y==7)
data_out=out_y8;
else 
data_out=0;
end
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
input [log_memX-1:0]addr_a;
input logic addr_y;
output logic signed[2*width-1:0] data_out;
logic signed[width-1:0]x_sig,a_sig;
logic signed[2*width-1:0]mult_sig,mult_r_sig,add_sig,add_r_sig;

//instantiating memory modules as needed in Fig. 6

module_mem #(width,(vec_size), log_memX) memX (.clk(clk),.addr(addr_x),.wr_en(wr_en_x),.data_in(data_in),.data_out(x_sig));
module_mem #(width,(vec_size), log_memX) memA (.clk(clk),.addr(addr_a),.wr_en(wr_en_a),.data_in(data_in),.data_out(a_sig));
module_mem #(2*width,1, 1) memY (.clk(clk),.addr(addr_y),.wr_en(wr_en_y),.data_in(add_r_sig),.data_out(data_out));

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
sel_y,
wr_en_a1,addr_a1,
wr_en_a2,addr_a2,
wr_en_a3,addr_a3,
wr_en_a4,addr_a4,
wr_en_a5,addr_a5,
wr_en_a6,addr_a6,
wr_en_a7,addr_a7,
wr_en_a8,addr_a8,
);
parameter log_memX=2, log_memA=4, k = 4,p=1,b=8,g=0;
input clk, start, reset,loadMatrix,loadVector;
output logic wr_en_x,wr_en_y;
output logic [log_memX-1:0]addr_x;
output logic done, clear_acc;
output logic [log_memX-1:0] sel_y;
output logic wr_en_a1;
output logic [log_memX-1:0]addr_a1;
output logic wr_en_a2;
output logic [log_memX-1:0]addr_a2;
output logic wr_en_a3;
output logic [log_memX-1:0]addr_a3;
output logic wr_en_a4;
output logic [log_memX-1:0]addr_a4;
output logic wr_en_a5;
output logic [log_memX-1:0]addr_a5;
output logic wr_en_a6;
output logic [log_memX-1:0]addr_a6;
output logic wr_en_a7;
output logic [log_memX-1:0]addr_a7;
output logic wr_en_a8;
output logic [log_memX-1:0]addr_a8;
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
sel_y<=0;
wr_en_y<=0;
clear_acc<=0;
done<=0;
i<=0;j<=0;q<=0;r<=0;
wr_en_a1<=0;
addr_a1<=0;
wr_en_a2<=0;
addr_a2<=0;
wr_en_a3<=0;
addr_a3<=0;
wr_en_a4<=0;
addr_a4<=0;
wr_en_a5<=0;
addr_a5<=0;
wr_en_a6<=0;
addr_a6<=0;
wr_en_a7<=0;
addr_a7<=0;
wr_en_a8<=0;
addr_a8<=0;
end
else begin
if(loadMatrix==1 || state==2&i<k*k) begin
addr_x<=0;
wr_en_x<=0;
state<=2;
if(i<1*k)begin
addr_a1 <= i;
wr_en_a1<=1;
end
else if(i<2*k)begin
addr_a2 <= i%8;
wr_en_a2<=1;
wr_en_a1<=0;
end
else if(i<3*k)begin
addr_a3 <= i%8;
wr_en_a3<=1;
wr_en_a2<=0;
end
else if(i<4*k)begin
addr_a4 <= i%8;
wr_en_a4<=1;
wr_en_a3<=0;
end
else if(i<5*k)begin
addr_a5 <= i%8;
wr_en_a5<=1;
wr_en_a4<=0;
end
else if(i<6*k)begin
addr_a6 <= i%8;
wr_en_a6<=1;
wr_en_a5<=0;
end
else if(i<7*k)begin
addr_a7 <= i%8;
wr_en_a7<=1;
wr_en_a6<=0;
end
else if(i<8*k)begin
addr_a8 <= i%8;
wr_en_a8<=1;
wr_en_a7<=0;
end
i<=i+1;
end
else if(state==2&&i==k*k)begin
wr_en_a8<=0;
end
if(loadVector==1||(state ==3 && j<k))begin
state<=3;
addr_x<=j;
wr_en_x<=1;
i<=0;
j<=j+1;
end
else if(state==3&&j==k)begin
wr_en_x<=0;
end
 if(start==1)begin //cleares the flipflop and initiates memory addresses to start MAC operation
state<=4;
addr_x<=0;
wr_en_x<=0;
wr_en_a1<=0;
addr_a1<=0;
wr_en_a2<=0;
addr_a2<=0;
wr_en_a3<=0;
addr_a3<=0;
wr_en_a4<=0;
addr_a4<=0;
wr_en_a5<=0;
addr_a5<=0;
wr_en_a6<=0;
addr_a6<=0;
wr_en_a7<=0;
addr_a7<=0;
wr_en_a8<=0;
addr_a8<=0;
clear_acc<=1;
j<=1;
end
else if(state==4 || (state==5 && j<k))begin //start reading from matrix A and vector X
state<=5;
clear_acc<=0;
addr_x<=j;
j<=j+1;
q<=0;
addr_a1<=j;
addr_a2<=j;
addr_a3<=j;
addr_a4<=j;
addr_a5<=j;
addr_a6<=j;
addr_a7<=j;
addr_a8<=j;
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
state<=8;
addr_x<=j;
wr_en_y<=1;
end
else if(state==8)begin//reads from memory Y
state<=9;
done<=1;
wr_en_y<=0;
end
else if(state==9&&r<k)begin
done<=0;
sel_y<=r;
r<=r+1;
end
else if (r==k)begin
state<=1;
addr_x<=0;
wr_en_x<=0;
sel_y<=0;
wr_en_y<=0;
clear_acc<=0;
done<=0;
i<=0;j<=0;q<=0;r<=0;
wr_en_a1<=0;
addr_a1<=0;
wr_en_a2<=0;
addr_a2<=0;
wr_en_a3<=0;
addr_a3<=0;
wr_en_a4<=0;
addr_a4<=0;
wr_en_a5<=0;
addr_a5<=0;
wr_en_a6<=0;
addr_a6<=0;
wr_en_a7<=0;
addr_a7<=0;
wr_en_a8<=0;
addr_a8<=0;
end
end
end
endmodule
