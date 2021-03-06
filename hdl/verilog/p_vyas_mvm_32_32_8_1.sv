// Example output, with parameters k=32, p=32, b=8, g=1

module mvm_32_32_8_1 (clk, reset,loadMatrix,loadVector,start,done,data_in,data_out);

parameter k=32,p=32,b=8,g=1,log_memX=5,log_memA=10;
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
logic [log_memX-1:0]addr_a9;
logic signed [2*b-1:0] out_y9;
logic wr_en_a9;
logic [log_memX-1:0]addr_a10;
logic signed [2*b-1:0] out_y10;
logic wr_en_a10;
logic [log_memX-1:0]addr_a11;
logic signed [2*b-1:0] out_y11;
logic wr_en_a11;
logic [log_memX-1:0]addr_a12;
logic signed [2*b-1:0] out_y12;
logic wr_en_a12;
logic [log_memX-1:0]addr_a13;
logic signed [2*b-1:0] out_y13;
logic wr_en_a13;
logic [log_memX-1:0]addr_a14;
logic signed [2*b-1:0] out_y14;
logic wr_en_a14;
logic [log_memX-1:0]addr_a15;
logic signed [2*b-1:0] out_y15;
logic wr_en_a15;
logic [log_memX-1:0]addr_a16;
logic signed [2*b-1:0] out_y16;
logic wr_en_a16;
logic [log_memX-1:0]addr_a17;
logic signed [2*b-1:0] out_y17;
logic wr_en_a17;
logic [log_memX-1:0]addr_a18;
logic signed [2*b-1:0] out_y18;
logic wr_en_a18;
logic [log_memX-1:0]addr_a19;
logic signed [2*b-1:0] out_y19;
logic wr_en_a19;
logic [log_memX-1:0]addr_a20;
logic signed [2*b-1:0] out_y20;
logic wr_en_a20;
logic [log_memX-1:0]addr_a21;
logic signed [2*b-1:0] out_y21;
logic wr_en_a21;
logic [log_memX-1:0]addr_a22;
logic signed [2*b-1:0] out_y22;
logic wr_en_a22;
logic [log_memX-1:0]addr_a23;
logic signed [2*b-1:0] out_y23;
logic wr_en_a23;
logic [log_memX-1:0]addr_a24;
logic signed [2*b-1:0] out_y24;
logic wr_en_a24;
logic [log_memX-1:0]addr_a25;
logic signed [2*b-1:0] out_y25;
logic wr_en_a25;
logic [log_memX-1:0]addr_a26;
logic signed [2*b-1:0] out_y26;
logic wr_en_a26;
logic [log_memX-1:0]addr_a27;
logic signed [2*b-1:0] out_y27;
logic wr_en_a27;
logic [log_memX-1:0]addr_a28;
logic signed [2*b-1:0] out_y28;
logic wr_en_a28;
logic [log_memX-1:0]addr_a29;
logic signed [2*b-1:0] out_y29;
logic wr_en_a29;
logic [log_memX-1:0]addr_a30;
logic signed [2*b-1:0] out_y30;
logic wr_en_a30;
logic [log_memX-1:0]addr_a31;
logic signed [2*b-1:0] out_y31;
logic wr_en_a31;
logic [log_memX-1:0]addr_a32;
logic signed [2*b-1:0] out_y32;
logic wr_en_a32;
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
.addr_a9(addr_a9),
.wr_en_a9(wr_en_a9),
.addr_a10(addr_a10),
.wr_en_a10(wr_en_a10),
.addr_a11(addr_a11),
.wr_en_a11(wr_en_a11),
.addr_a12(addr_a12),
.wr_en_a12(wr_en_a12),
.addr_a13(addr_a13),
.wr_en_a13(wr_en_a13),
.addr_a14(addr_a14),
.wr_en_a14(wr_en_a14),
.addr_a15(addr_a15),
.wr_en_a15(wr_en_a15),
.addr_a16(addr_a16),
.wr_en_a16(wr_en_a16),
.addr_a17(addr_a17),
.wr_en_a17(wr_en_a17),
.addr_a18(addr_a18),
.wr_en_a18(wr_en_a18),
.addr_a19(addr_a19),
.wr_en_a19(wr_en_a19),
.addr_a20(addr_a20),
.wr_en_a20(wr_en_a20),
.addr_a21(addr_a21),
.wr_en_a21(wr_en_a21),
.addr_a22(addr_a22),
.wr_en_a22(wr_en_a22),
.addr_a23(addr_a23),
.wr_en_a23(wr_en_a23),
.addr_a24(addr_a24),
.wr_en_a24(wr_en_a24),
.addr_a25(addr_a25),
.wr_en_a25(wr_en_a25),
.addr_a26(addr_a26),
.wr_en_a26(wr_en_a26),
.addr_a27(addr_a27),
.wr_en_a27(wr_en_a27),
.addr_a28(addr_a28),
.wr_en_a28(wr_en_a28),
.addr_a29(addr_a29),
.wr_en_a29(wr_en_a29),
.addr_a30(addr_a30),
.wr_en_a30(wr_en_a30),
.addr_a31(addr_a31),
.wr_en_a31(wr_en_a31),
.addr_a32(addr_a32),
.wr_en_a32(wr_en_a32),
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
module_datapath #(b,k,log_memA,log_memX,p,g) data_path9(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a9),.addr_a(addr_a9),
.data_in(data_in),.data_out(out_y9));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path10(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a10),.addr_a(addr_a10),
.data_in(data_in),.data_out(out_y10));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path11(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a11),.addr_a(addr_a11),
.data_in(data_in),.data_out(out_y11));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path12(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a12),.addr_a(addr_a12),
.data_in(data_in),.data_out(out_y12));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path13(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a13),.addr_a(addr_a13),
.data_in(data_in),.data_out(out_y13));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path14(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a14),.addr_a(addr_a14),
.data_in(data_in),.data_out(out_y14));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path15(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a15),.addr_a(addr_a15),
.data_in(data_in),.data_out(out_y15));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path16(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a16),.addr_a(addr_a16),
.data_in(data_in),.data_out(out_y16));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path17(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a17),.addr_a(addr_a17),
.data_in(data_in),.data_out(out_y17));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path18(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a18),.addr_a(addr_a18),
.data_in(data_in),.data_out(out_y18));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path19(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a19),.addr_a(addr_a19),
.data_in(data_in),.data_out(out_y19));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path20(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a20),.addr_a(addr_a20),
.data_in(data_in),.data_out(out_y20));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path21(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a21),.addr_a(addr_a21),
.data_in(data_in),.data_out(out_y21));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path22(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a22),.addr_a(addr_a22),
.data_in(data_in),.data_out(out_y22));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path23(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a23),.addr_a(addr_a23),
.data_in(data_in),.data_out(out_y23));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path24(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a24),.addr_a(addr_a24),
.data_in(data_in),.data_out(out_y24));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path25(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a25),.addr_a(addr_a25),
.data_in(data_in),.data_out(out_y25));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path26(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a26),.addr_a(addr_a26),
.data_in(data_in),.data_out(out_y26));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path27(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a27),.addr_a(addr_a27),
.data_in(data_in),.data_out(out_y27));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path28(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a28),.addr_a(addr_a28),
.data_in(data_in),.data_out(out_y28));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path29(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a29),.addr_a(addr_a29),
.data_in(data_in),.data_out(out_y29));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path30(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a30),.addr_a(addr_a30),
.data_in(data_in),.data_out(out_y30));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path31(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a31),.addr_a(addr_a31),
.data_in(data_in),.data_out(out_y31));
module_datapath #(b,k,log_memA,log_memX,p,g) data_path32(.clk(clk),.clear_acc(clear_acc),
.addr_x(addr_x),.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),.addr_y(1'b0),
.wr_en_a(wr_en_a32),.addr_a(addr_a32),
.data_in(data_in),.data_out(out_y32));
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
else if(sel_y==8)
data_out=out_y9;
else if(sel_y==9)
data_out=out_y10;
else if(sel_y==10)
data_out=out_y11;
else if(sel_y==11)
data_out=out_y12;
else if(sel_y==12)
data_out=out_y13;
else if(sel_y==13)
data_out=out_y14;
else if(sel_y==14)
data_out=out_y15;
else if(sel_y==15)
data_out=out_y16;
else if(sel_y==16)
data_out=out_y17;
else if(sel_y==17)
data_out=out_y18;
else if(sel_y==18)
data_out=out_y19;
else if(sel_y==19)
data_out=out_y20;
else if(sel_y==20)
data_out=out_y21;
else if(sel_y==21)
data_out=out_y22;
else if(sel_y==22)
data_out=out_y23;
else if(sel_y==23)
data_out=out_y24;
else if(sel_y==24)
data_out=out_y25;
else if(sel_y==25)
data_out=out_y26;
else if(sel_y==26)
data_out=out_y27;
else if(sel_y==27)
data_out=out_y28;
else if(sel_y==28)
data_out=out_y29;
else if(sel_y==29)
data_out=out_y30;
else if(sel_y==30)
data_out=out_y31;
else if(sel_y==31)
data_out=out_y32;
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
wr_en_a9,addr_a9,
wr_en_a10,addr_a10,
wr_en_a11,addr_a11,
wr_en_a12,addr_a12,
wr_en_a13,addr_a13,
wr_en_a14,addr_a14,
wr_en_a15,addr_a15,
wr_en_a16,addr_a16,
wr_en_a17,addr_a17,
wr_en_a18,addr_a18,
wr_en_a19,addr_a19,
wr_en_a20,addr_a20,
wr_en_a21,addr_a21,
wr_en_a22,addr_a22,
wr_en_a23,addr_a23,
wr_en_a24,addr_a24,
wr_en_a25,addr_a25,
wr_en_a26,addr_a26,
wr_en_a27,addr_a27,
wr_en_a28,addr_a28,
wr_en_a29,addr_a29,
wr_en_a30,addr_a30,
wr_en_a31,addr_a31,
wr_en_a32,addr_a32,
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
output logic wr_en_a9;
output logic [log_memX-1:0]addr_a9;
output logic wr_en_a10;
output logic [log_memX-1:0]addr_a10;
output logic wr_en_a11;
output logic [log_memX-1:0]addr_a11;
output logic wr_en_a12;
output logic [log_memX-1:0]addr_a12;
output logic wr_en_a13;
output logic [log_memX-1:0]addr_a13;
output logic wr_en_a14;
output logic [log_memX-1:0]addr_a14;
output logic wr_en_a15;
output logic [log_memX-1:0]addr_a15;
output logic wr_en_a16;
output logic [log_memX-1:0]addr_a16;
output logic wr_en_a17;
output logic [log_memX-1:0]addr_a17;
output logic wr_en_a18;
output logic [log_memX-1:0]addr_a18;
output logic wr_en_a19;
output logic [log_memX-1:0]addr_a19;
output logic wr_en_a20;
output logic [log_memX-1:0]addr_a20;
output logic wr_en_a21;
output logic [log_memX-1:0]addr_a21;
output logic wr_en_a22;
output logic [log_memX-1:0]addr_a22;
output logic wr_en_a23;
output logic [log_memX-1:0]addr_a23;
output logic wr_en_a24;
output logic [log_memX-1:0]addr_a24;
output logic wr_en_a25;
output logic [log_memX-1:0]addr_a25;
output logic wr_en_a26;
output logic [log_memX-1:0]addr_a26;
output logic wr_en_a27;
output logic [log_memX-1:0]addr_a27;
output logic wr_en_a28;
output logic [log_memX-1:0]addr_a28;
output logic wr_en_a29;
output logic [log_memX-1:0]addr_a29;
output logic wr_en_a30;
output logic [log_memX-1:0]addr_a30;
output logic wr_en_a31;
output logic [log_memX-1:0]addr_a31;
output logic wr_en_a32;
output logic [log_memX-1:0]addr_a32;
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
wr_en_a9<=0;
addr_a9<=0;
wr_en_a10<=0;
addr_a10<=0;
wr_en_a11<=0;
addr_a11<=0;
wr_en_a12<=0;
addr_a12<=0;
wr_en_a13<=0;
addr_a13<=0;
wr_en_a14<=0;
addr_a14<=0;
wr_en_a15<=0;
addr_a15<=0;
wr_en_a16<=0;
addr_a16<=0;
wr_en_a17<=0;
addr_a17<=0;
wr_en_a18<=0;
addr_a18<=0;
wr_en_a19<=0;
addr_a19<=0;
wr_en_a20<=0;
addr_a20<=0;
wr_en_a21<=0;
addr_a21<=0;
wr_en_a22<=0;
addr_a22<=0;
wr_en_a23<=0;
addr_a23<=0;
wr_en_a24<=0;
addr_a24<=0;
wr_en_a25<=0;
addr_a25<=0;
wr_en_a26<=0;
addr_a26<=0;
wr_en_a27<=0;
addr_a27<=0;
wr_en_a28<=0;
addr_a28<=0;
wr_en_a29<=0;
addr_a29<=0;
wr_en_a30<=0;
addr_a30<=0;
wr_en_a31<=0;
addr_a31<=0;
wr_en_a32<=0;
addr_a32<=0;
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
addr_a2 <= i%32;
wr_en_a2<=1;
wr_en_a1<=0;
end
else if(i<3*k)begin
addr_a3 <= i%32;
wr_en_a3<=1;
wr_en_a2<=0;
end
else if(i<4*k)begin
addr_a4 <= i%32;
wr_en_a4<=1;
wr_en_a3<=0;
end
else if(i<5*k)begin
addr_a5 <= i%32;
wr_en_a5<=1;
wr_en_a4<=0;
end
else if(i<6*k)begin
addr_a6 <= i%32;
wr_en_a6<=1;
wr_en_a5<=0;
end
else if(i<7*k)begin
addr_a7 <= i%32;
wr_en_a7<=1;
wr_en_a6<=0;
end
else if(i<8*k)begin
addr_a8 <= i%32;
wr_en_a8<=1;
wr_en_a7<=0;
end
else if(i<9*k)begin
addr_a9 <= i%32;
wr_en_a9<=1;
wr_en_a8<=0;
end
else if(i<10*k)begin
addr_a10 <= i%32;
wr_en_a10<=1;
wr_en_a9<=0;
end
else if(i<11*k)begin
addr_a11 <= i%32;
wr_en_a11<=1;
wr_en_a10<=0;
end
else if(i<12*k)begin
addr_a12 <= i%32;
wr_en_a12<=1;
wr_en_a11<=0;
end
else if(i<13*k)begin
addr_a13 <= i%32;
wr_en_a13<=1;
wr_en_a12<=0;
end
else if(i<14*k)begin
addr_a14 <= i%32;
wr_en_a14<=1;
wr_en_a13<=0;
end
else if(i<15*k)begin
addr_a15 <= i%32;
wr_en_a15<=1;
wr_en_a14<=0;
end
else if(i<16*k)begin
addr_a16 <= i%32;
wr_en_a16<=1;
wr_en_a15<=0;
end
else if(i<17*k)begin
addr_a17 <= i%32;
wr_en_a17<=1;
wr_en_a16<=0;
end
else if(i<18*k)begin
addr_a18 <= i%32;
wr_en_a18<=1;
wr_en_a17<=0;
end
else if(i<19*k)begin
addr_a19 <= i%32;
wr_en_a19<=1;
wr_en_a18<=0;
end
else if(i<20*k)begin
addr_a20 <= i%32;
wr_en_a20<=1;
wr_en_a19<=0;
end
else if(i<21*k)begin
addr_a21 <= i%32;
wr_en_a21<=1;
wr_en_a20<=0;
end
else if(i<22*k)begin
addr_a22 <= i%32;
wr_en_a22<=1;
wr_en_a21<=0;
end
else if(i<23*k)begin
addr_a23 <= i%32;
wr_en_a23<=1;
wr_en_a22<=0;
end
else if(i<24*k)begin
addr_a24 <= i%32;
wr_en_a24<=1;
wr_en_a23<=0;
end
else if(i<25*k)begin
addr_a25 <= i%32;
wr_en_a25<=1;
wr_en_a24<=0;
end
else if(i<26*k)begin
addr_a26 <= i%32;
wr_en_a26<=1;
wr_en_a25<=0;
end
else if(i<27*k)begin
addr_a27 <= i%32;
wr_en_a27<=1;
wr_en_a26<=0;
end
else if(i<28*k)begin
addr_a28 <= i%32;
wr_en_a28<=1;
wr_en_a27<=0;
end
else if(i<29*k)begin
addr_a29 <= i%32;
wr_en_a29<=1;
wr_en_a28<=0;
end
else if(i<30*k)begin
addr_a30 <= i%32;
wr_en_a30<=1;
wr_en_a29<=0;
end
else if(i<31*k)begin
addr_a31 <= i%32;
wr_en_a31<=1;
wr_en_a30<=0;
end
else if(i<32*k)begin
addr_a32 <= i%32;
wr_en_a32<=1;
wr_en_a31<=0;
end
i<=i+1;
end
else if(state==2&&i==k*k)begin
wr_en_a32<=0;
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
wr_en_a9<=0;
addr_a9<=0;
wr_en_a10<=0;
addr_a10<=0;
wr_en_a11<=0;
addr_a11<=0;
wr_en_a12<=0;
addr_a12<=0;
wr_en_a13<=0;
addr_a13<=0;
wr_en_a14<=0;
addr_a14<=0;
wr_en_a15<=0;
addr_a15<=0;
wr_en_a16<=0;
addr_a16<=0;
wr_en_a17<=0;
addr_a17<=0;
wr_en_a18<=0;
addr_a18<=0;
wr_en_a19<=0;
addr_a19<=0;
wr_en_a20<=0;
addr_a20<=0;
wr_en_a21<=0;
addr_a21<=0;
wr_en_a22<=0;
addr_a22<=0;
wr_en_a23<=0;
addr_a23<=0;
wr_en_a24<=0;
addr_a24<=0;
wr_en_a25<=0;
addr_a25<=0;
wr_en_a26<=0;
addr_a26<=0;
wr_en_a27<=0;
addr_a27<=0;
wr_en_a28<=0;
addr_a28<=0;
wr_en_a29<=0;
addr_a29<=0;
wr_en_a30<=0;
addr_a30<=0;
wr_en_a31<=0;
addr_a31<=0;
wr_en_a32<=0;
addr_a32<=0;
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
addr_a9<=j;
addr_a10<=j;
addr_a11<=j;
addr_a12<=j;
addr_a13<=j;
addr_a14<=j;
addr_a15<=j;
addr_a16<=j;
addr_a17<=j;
addr_a18<=j;
addr_a19<=j;
addr_a20<=j;
addr_a21<=j;
addr_a22<=j;
addr_a23<=j;
addr_a24<=j;
addr_a25<=j;
addr_a26<=j;
addr_a27<=j;
addr_a28<=j;
addr_a29<=j;
addr_a30<=j;
addr_a31<=j;
addr_a32<=j;
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
wr_en_a9<=0;
addr_a9<=0;
wr_en_a10<=0;
addr_a10<=0;
wr_en_a11<=0;
addr_a11<=0;
wr_en_a12<=0;
addr_a12<=0;
wr_en_a13<=0;
addr_a13<=0;
wr_en_a14<=0;
addr_a14<=0;
wr_en_a15<=0;
addr_a15<=0;
wr_en_a16<=0;
addr_a16<=0;
wr_en_a17<=0;
addr_a17<=0;
wr_en_a18<=0;
addr_a18<=0;
wr_en_a19<=0;
addr_a19<=0;
wr_en_a20<=0;
addr_a20<=0;
wr_en_a21<=0;
addr_a21<=0;
wr_en_a22<=0;
addr_a22<=0;
wr_en_a23<=0;
addr_a23<=0;
wr_en_a24<=0;
addr_a24<=0;
wr_en_a25<=0;
addr_a25<=0;
wr_en_a26<=0;
addr_a26<=0;
wr_en_a27<=0;
addr_a27<=0;
wr_en_a28<=0;
addr_a28<=0;
wr_en_a29<=0;
addr_a29<=0;
wr_en_a30<=0;
addr_a30<=0;
wr_en_a31<=0;
addr_a31<=0;
wr_en_a32<=0;
addr_a32<=0;
end
end
end
endmodule
