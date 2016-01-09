#include <stdio.h>
#include <stdlib.h>
#include<math.h>

// Usage: run this as ./gen k p b g

int main(int argc, char *argv[]) {

  if (argc != 5) { // argc == 5 means 4 arguments
    printf("ERROR: requires four arguments ./gen k p b g\n");
    exit(0);
  }

  // Read k, p, b, and g from command line.
  // You should make sure you check that k, p, b, and g are valid.  Make sure if you enter
  // e.g. b=-2 your generator prints an error message.
  int k = atoi(argv[1]);
  int p = atoi(argv[2]);
  int b = atoi(argv[3]);
  int g = atoi(argv[4]);

  int x = ceil(log(k)/log(2));
  int y = ceil(log(k*k)/log(2));
  int m;
  
  if(k<1||p<1||b<1){
    printf("invalid entry. \"k\" \"p\" \"b\" should be a positive nonzero integer\n");
     exit(0);
    }
	if (!(g==0||g==1)){
		printf("invalid entry. \"g\" can have two cases 0 or 1\n");
		exit(0);
	}
  if(!(p==k||p==1)){
	  printf("invalid entry. \"p\" can only have two cases \"1\" or \"k\"");
	  exit(0);
  }
  
  
   
  	//begin code section to generate ref data and expected outputs
   int desiredInputs = 1000;
	//int k = 4;
	long array_A[k][k];
	long  array_X[k];
	int line_count=0;
	srand(time(NULL)); // Set random seed based on current time

  //initializing file pointers
  //inputData is read by the testbench to generate outputs
  //expectedOutput is the correct set of outputs and is used to 
  //   compare with the module
  FILE *inputData, *expectedOutput;
  char buf1[100],buf2[100];
  
  //initializing file pointers
  //inputData = fopen("refData_%d_%d_%d_%d.mem", "w",k,p,b,g);
  //expectedOutput = fopen("expectedOutput", "w");
  printf("files generated by the code for testing\n\n");
  snprintf (buf1,100,"refData_%d_%d_%d_%d.mem",k,p,b,g);
  printf("%s => this file contains randomly generated inputs\n\n",buf1);
  inputData = fopen(buf1,"w");
  
  snprintf (buf2,100,"expectedOutput_%d_%d_%d_%d",k,p,b,g);
  printf("%s => this file contains the output that is expected from the hardware \n\n",buf2);
  expectedOutput = fopen(buf2,"w");
  
  printf("outValues_%d_%d_%d_%d => this file contains the output of our hardware\n \n ",k,p,b,g);
  
 long long range = pow(2,b);
 long long overflow = pow(2,b)*pow(2,b);
 long long  hex_size = pow(2,ceil(b/4.0)*4)-1; 
  int mode,i,l=0,olda=0,oldb=0,r;
 long long a;
 long j = 0;
 long long temp;    
  int f=-1;
 
  for (i=0; i<desiredInputs; i++) {
	//specify one of the four input modes:
	//mode 1: load matrix followed by load vector
	//mode 2: load vector followed by load matrix
	//mode 3: load matrix only
	//mode 4: load vector only
 if(i==0)
   mode=1; //to make sure the vector and matrix are not dont cares
 else
	mode = rand()%4+1;
 
 fprintf(inputData, "%llx\n",(mode&hex_size),mode);//write mode to file
 line_count++;
 
	if(mode==1||mode==3) {
   for(j=0;j<k*k;j++){
			a = (rand() % range-(range/2));//produce inputs for matrix A
			fprintf(inputData, "%llx\n",(a&hex_size),a);//write input for A to file
			line_count++;
			array_A[j/k][j%k]=a;
		}
	}
	if(mode==1||mode==2||mode==4){
		for(j=0;j<k;j++){
		a= (rand() % range-(range/2));//produce intputs for matrix X
		fprintf(inputData,"%llx\n",(a&hex_size),a);//write input for X to file
		line_count++;
		array_X[j]=a;
		}
	}
	if(mode==2){//populate the matrix after vector only in this mode
		for(j=0;j<k*k;j++){
			a = (rand() % range-(range/2));//produce inputs for matrix A
			fprintf(inputData, "%llx\n",(a&hex_size),a);//write input for A to file
			line_count++;
			array_A[j/k][j%k]=a;
		}
	}
	

	//calculate output values
	for(j=0;j<k;j++){
		temp=0;
		for(l=0;l<k;l++){
			temp=(temp+array_A[j][l]*array_X[l]);
			
		}
		//conditions to handle signed b bit overflow in MAC unit
		if(temp<-(overflow/2))
			temp=overflow+temp%overflow;
      if(temp<-overflow||temp>overflow-1)
      temp = temp%overflow;
      
		if(temp>(overflow/2-1))
			temp=temp%overflow-overflow;
     
		
		fprintf(expectedOutput,"%lld\n",(temp));
		
	}
 
	fprintf(expectedOutput,"---\n");
	
  } 
	//end code for generating ref data and expected output
  
  
  
  
  
  
  
  
  
  
  // Open output file for writing.
  FILE *outfile,*testfile;
  char fname[100], tname[100];

  sprintf(tname, "p_vyas_mvm_tb_%d_%d_%d_%d.sv",k,p,b,g);
  if((testfile = fopen(tname, "w")) == NULL)
    {
      printf("Error: cannot open file %s for writting.\n",tname);
      exit(0);
    }
    
    fprintf(testfile,"`include \"p_vyas_mvm_%d_%d_%d_%d.sv\"\n", k,p,b,g);
   fprintf(testfile,"///////////////////////////////////////////////////////////////////\n"
"//Module: tbench\n"
"///////////////////////////////////////////////////////////////////\n"
"module tbench();\n"
"parameter k =%d,b = %d,test_size=1000,period=10,latency=1500*period,\n"
"data_matrix = k*k,\n"
"data_vector = k,\n"
"data_len = %d;\n"


	"logic clk,reset,start;\n"
   "logic loadMatrix,loadVector;\n"
	"logic  done;\n"
	"logic signed [b-1:0]data_in;\n"
	"logic  signed [2*b-1:0]data_out;\n"
	
 
 
	"initial clk=0;\n"
 
 
  
   "always #(period/2) clk=~clk;\n",k,b,(line_count-1));
   

	fprintf(testfile,"mvm_%d_%d_%d_%d dut(clk,reset,loadMatrix,loadVector,start,done,data_in,data_out);\n",k,p,b,g);
	fprintf(testfile,"logic [b-1:0] testData[data_len:0];\n"
	"integer line_pos;//line_pos shows where the mode value is for an iteration\n"
	"initial $readmemh(\"refData_%d_%d_%d_%d.mem\", testData);\n"
	"integer l,q;\n"
   "integer i,mode,jump;\n"
   "int j;\n"
   "initial begin\n"
  
		"#1;\n"
		"l<=0;\n"
		"line_pos=0;\n"
     "q<=k;\n"
			"reset = 1;\n"
			"#period;\n"
			"reset = 0;\n"
		
		"for (i=0; i<test_size; i=i+1) begin\n"
   "mode = testData[line_pos];\n"
   "//assign a value for jump\n"
"if(mode == 1||mode == 2)\n"
	"jump = data_matrix+data_vector;\n"
"else if(mode == 3)\n"
	"jump = data_matrix;\n"
"else if(mode == 4)\n"
	"jump = data_vector;\n"

	"#1;\n"
"//assert load Matrix and load Vector according to mode\n"
"if(mode==1)begin\n"
     "loadMatrix = 1;\n"
	"#period;\n"
	"loadMatrix=0;\n"
	"for (j=line_pos+1;j<=line_pos+data_matrix+1;j=j+1)/*(j=i*(data_matrix)+i*q;j<(i+1)*data_matrix+i*q;j=j+1)*/begin\n"
		"data_in = testData[j];\n"
		"#period;\n"
	"end\n"
	"#(period*(j %% 10));\n"
	"loadVector = 1;\n"
	"#period;\n"
	"loadVector = 0;\n"
	"for (j=line_pos+data_matrix+1;j<=line_pos+jump;j=j+1)/*(j=(i+1)*data_matrix+i*q;j<(i+1)*data_matrix+data_vector+i*q;j=j+1)*/begin\n"
		"data_in = testData[j];\n"
		"#period ;\n"
	"end\n"
"end\n"
"else if(mode==2)begin	\n"
	"loadVector = 1;\n"
	"#period;\n"
	"loadVector = 0;\n"
	"for (j=line_pos+1;j<=line_pos+data_vector;j=j+1)/*(j=(i+1)*data_matrix+i*q;j<(i+1)*data_matrix+data_vector+i*q;j=j+1)*/begin\n"
	"data_in = testData[j];\n"
	"#period ;\n"
	"end\n"
	"#(period*(j %% 10));\n"
	"loadMatrix = 1;\n"
	"#period;\n"
	"loadMatrix=0;\n"
	"for (j=line_pos+data_vector+1;j<=line_pos+jump;j=j+1)/*(j=i*(data_matrix)+i*q;j<(i+1)*data_matrix+i*q;j=j+1)*/begin\n"
		"data_in = testData[j];\n"
		"#period ;\n"
	"end\n"
"end\n"

"else if(mode==3)begin\n"
	"loadMatrix = 1;\n"
	"#period;\n"
	"loadMatrix = 0;\n"
	"for (j=line_pos+1;j<=line_pos+jump;j=j+1)begin\n"
	"data_in = testData[j];\n"
	"#period ;\n"
	"end\n"
"end\n"

"else if(mode==4)begin\n"
	"loadVector = 1;\n"
	"#period;\n"
	"loadVector = 0;\n"
	"for (j=line_pos+1;j<=line_pos+jump;j=j+1)begin\n"
	"data_in = testData[j];\n"
	"#period ;\n"
	"end\n"
"end\n"
			
			"#(period*(j %% 10));\n"
			"start = 1;\n"
			"#period;\n"
			
			"start=0;\n"				
			
			"@(posedge done)#(period*(data_vector+1));\n"
		"line_pos=line_pos+jump+1;//go to the line with the next mode value\n"
		"#(period*((j*3) %% 10));\n"
		"end\n"
		"#period;//wait for a couple of cycles to finish writing to outValues;\n"
		"#period;\n"


		"$fclose(filehandle);\n"
		"$finish;\n"
		"end\n",k,p,b,g);
   
   
	
   fprintf(testfile,"integer filehandle=$fopen(\"outValues_%d_%d_%d_%d\");\n"
  
	"//This writes the outputs to outValues when the done signal is asserted\n"
	"always @(posedge clk)begin\n"
		"if(done==1)begin\n"
			"l<=1;\n"
		"end\n"
		"if(l>=1 && l<=k)begin\n"
			"$fdisplay(filehandle, \"%%d\",data_out);\n"
			"l<=l+1;\n"
			"if(l==k)begin\n"
			"$fdisplay(filehandle,\"---\");\n"
				"l<=0;\n"
			"end\n"
		"end\n"
		
	"end\n"	

"endmodule\n",k,p,b,g);

  fclose(testfile);
 
  // replace the p_vyas_mvm part
  sprintf(fname, "p_vyas_mvm_%d_%d_%d_%d.sv", k, p, b, g);
  if ((outfile = fopen(fname, "w")) == NULL) {
      printf("Error: cannot open file %s for writing.\n", fname);
      exit(0);
  }

  fprintf(outfile, "// Example output, with parameters k=%d, p=%d, b=%d, g=%d\n\n", k, p, b, g);
  fprintf(outfile, "module mvm_%d_%d_%d_%d (clk, reset,loadMatrix,loadVector,start,done,data_in,data_out);\n\n", k, p, b, g);
  fprintf(outfile, "parameter k=%d,p=%d,b=%d,g=%d,log_memX=%d,log_memA=%d;\n"

	"input   clk,reset,start,loadMatrix,loadVector;\n"
	"output  done;\n"
	"input  signed [b-1:0]data_in;\n"
	"output logic signed [2*b-1:0]data_out;\n",k,p,b,g,x,y);
	
	if(p==1)//fully linear system
	{

	fprintf(outfile,"logic [log_memX-1:0]addr_x, addr_y;\n"
	"logic [log_memA-1:0]addr_a;\n"
	"logic wr_en_a,wr_en_x,wr_en_y,clear_acc;\n"
	"logic [3:0]state; \n ");
 
   fprintf(outfile,"module_control #(log_memX,log_memA, k,p,b,g) ctrl_path(.clk(clk), .start(start), .reset(reset),.loadMatrix(loadMatrix),.loadVector(loadVector),"
	".addr_x(addr_x),.wr_en_x(wr_en_x),\n"
	".addr_a(addr_a),.wr_en_a(wr_en_a),\n"
	".addr_y(addr_y),.wr_en_y(wr_en_y),\n"
	".clear_acc(clear_acc),.done(done));\n"
	
	"module_datapath #(b,k,log_memA,log_memX,p,g) data_path(.clk(clk),.clear_acc(clear_acc),\n"
	".addr_x(addr_x),.wr_en_x(wr_en_x),\n"
	".wr_en_y(wr_en_y),.addr_y(addr_y),\n"
	".wr_en_a(wr_en_a),.addr_a(addr_a),\n"
	".data_in(data_in),.data_out(data_out));\n"
  "endmodule\n\n\n");
	}
	else if(p==k)//fully parallel system
	{
		fprintf(outfile,"logic [log_memX-1:0]addr_x, sel_y;\n"
		"logic [3:0]state; \n "
		"logic wr_en_x,wr_en_y,clear_acc;"	);
		
		for(m=1;m<p+1;m++)
		{
			fprintf(outfile,"logic [log_memX-1:0]addr_a%d;\n"
			"logic signed [2*b-1:0] out_y%d;\n"
			"logic wr_en_a%d;\n",m,m,m);
		}
		
		fprintf(outfile,"module_control #(log_memX,log_memA, k,p,b,g) ctrl_path(.clk(clk), .start(start), .reset(reset),\n"
	".addr_x(addr_x),.wr_en_x(wr_en_x),\n"
	".wr_en_y(wr_en_y),.sel_y(sel_y),.loadMatrix(loadMatrix),.loadVector(loadVector),\n"
	".clear_acc(clear_acc),\n");
	
		for(m=1;m<p+1;m++)
		{
			fprintf(outfile,".addr_a%d(addr_a%d),\n"
			".wr_en_a%d(wr_en_a%d),\n",m,m,m,m);
			
		}
		fprintf(outfile,".done(done));\n");
		
		for(m=1;m<p+1;m++)
		{
			fprintf(outfile,"module_datapath #(b,k,log_memA,log_memX,p,g) data_path%d(.clk(clk),.clear_acc(clear_acc),\n"
	".addr_x(addr_x),.wr_en_x(wr_en_x),\n"
	".wr_en_y(wr_en_y),.addr_y(1'b0),\n"
	".wr_en_a(wr_en_a%d),.addr_a(addr_a%d),\n"
	".data_in(data_in),.data_out(out_y%d));\n",m,m,m,m);
			
		}
		
		fprintf(outfile,"always_comb begin\n"
			"if(sel_y==0)\n"
				"data_out=out_y1;\n");
			for(m=2;m<p+1;m++)	
			{
			fprintf(outfile,"else if(sel_y==%d)\n"
				"data_out=out_y%d;\n",m-1,m);
			}
			
			fprintf(outfile,"else \n"
				"data_out=0;\n"
		"end\n"
	
"endmodule\n");

	}
		
		
		
		
		
  fprintf(outfile, "module module_mem(clk,addr,wr_en,data_in,data_out);\n"

	"parameter WIDTH = 16, SIZE = 64,LOG_SIZE = 6;\n"

	"input logic wr_en,clk;\n"
	"input logic signed [WIDTH-1:0] data_in;\n"
	"input logic [LOG_SIZE-1:0] addr;\n"
	"output logic signed [WIDTH-1:0] data_out;\n"

	"logic [SIZE-1:0][WIDTH-1:0] mem;\n"
	"always_ff @(posedge clk)begin\n"
		"data_out <= mem[addr];//read\n"
		"if(wr_en)//write\n"
			"mem[addr]<=data_in;\n"
	"end\n"

"endmodule\n\n");

 fprintf(outfile, " module module_datapath(\n"
	"clk,clear_acc,\n"
	"addr_x,wr_en_x,\n"
	"wr_en_y,addr_y,\n"
	"wr_en_a,addr_a,\n"
	"data_in,data_out\n"
");\n"

	"parameter width = 8,vec_size=3,log_memA=4,log_memX=2,p=1,g=1;\n\n"
	"input signed [width-1:0] data_in;\n"
	"input logic wr_en_x,wr_en_y,wr_en_a,clear_acc,clk;\n"
	"input [log_memX-1:0]addr_x;\n");
	if(p==1)
	{
		fprintf(outfile,"input [log_memA-1:0]addr_a;\n"
		"input [log_memX-1:0]addr_y;\n");
	}
	if(p==k)
	{
		fprintf(outfile,"input [log_memX-1:0]addr_a;\n"
		"input logic addr_y;\n");
	}
	
	
	fprintf(outfile,"output logic signed[2*width-1:0] data_out;\n"

	"logic signed[width-1:0]x_sig,a_sig;\n"
	"logic signed[2*width-1:0]mult_sig,mult_r_sig,add_sig,add_r_sig;\n\n"
	 
	
	"//instantiating memory modules as needed in Fig. 6\n\n"
	
	
	"module_mem #(width,(vec_size), log_memX) memX (.clk(clk),.addr(addr_x),.wr_en(wr_en_x),.data_in(data_in),.data_out(x_sig));\n");
	if(p==1)
	{
		fprintf(outfile,"module_mem #(width,(vec_size*vec_size), log_memA) memA (.clk(clk),.addr(addr_a),.wr_en(wr_en_a),.data_in(data_in),.data_out(a_sig));\n"
	"module_mem #(2*width,(vec_size), log_memX) memY (.clk(clk),.addr(addr_y),.wr_en(wr_en_y),.data_in(add_r_sig),.data_out(data_out));\n\n");
	}
	
	if (p==k)
	{
		fprintf(outfile,"module_mem #(width,(vec_size), log_memX) memA (.clk(clk),.addr(addr_a),.wr_en(wr_en_a),.data_in(data_in),.data_out(a_sig));\n"
	"module_mem #(2*width,1, 1) memY (.clk(clk),.addr(addr_y),.wr_en(wr_en_y),.data_in(add_r_sig),.data_out(data_out));\n\n");
	}
	
	if(g==1)
	{
	fprintf(outfile,"always_comb begin\n"
			"mult_sig = x_sig * a_sig;//multiplier of Fig. 6\n"
			"add_sig = mult_r_sig+add_r_sig;//adder of Fig. 6\n"
			
			"end\n"
			
			"always_ff @(posedge clk)begin\n"
			"if(clear_acc==1)begin\n"
				"add_r_sig <=0;\n"
				"mult_r_sig<=0;\n"
			"end\n"
			"else begin\n"
			"add_r_sig <= add_sig;\n"
			"mult_r_sig<=mult_sig;\n"
			"end\n"
		"end\n"
		"endmodule\n\n\n");
		
	}

	if(g==0)
	{
		fprintf(outfile,"always_comb begin\n"
		
			"mult_sig = x_sig * a_sig;//multiplier of Fig. 6\n"
			"add_sig = mult_sig+add_r_sig;//adder of Fig. 6\n"
			"end\n"
			
		"always_ff @(posedge clk)begin\n"
			"if(clear_acc==1)begin\n"
				"add_r_sig <=0;\n"
			"end\n"
		"else begin\n"
			"add_r_sig <= add_sig;\n"
				"end\n"
			"end\n"
		"endmodule\n\n\n"
);
	}
fprintf(outfile, "///////////////////////////////////////////////////////////////////\n"
"//Module: module_control\n"
"//Description: the main module that handles the control needed in our system (control part of reg. transfer desc.)\n"
"///////////////////////////////////////////////////////////////////\n"
"module module_control(\n"
	"clk, start, reset,\n"
	"loadMatrix,loadVector,\n"
	"addr_x,wr_en_x,\n"
	"wr_en_y,\n"
	"clear_acc,done,\n");
	if(p==1)
	{
		fprintf(outfile,"addr_a,wr_en_a,\n"
		"addr_y\n");
		
	}
	
	if(p==k)
	{
		fprintf(outfile,"sel_y,\n");
		
		for(m=1;m<p+1;m++)
		{
			fprintf(outfile,"wr_en_a%d,addr_a%d,\n",m,m);
		}
	}
 fprintf(outfile,");\n"

	"parameter log_memX=2, log_memA=4, k = 4,p=1,b=8,g=0;\n"
	
	"input clk, start, reset,loadMatrix,loadVector;\n"
	"output logic wr_en_x,wr_en_y;\n"
	"output logic [log_memX-1:0]addr_x;\n"
	"output logic done, clear_acc;\n");
	
	if(p==1)
		{
			fprintf(outfile,"output logic wr_en_a;\n"
			"output logic [log_memX-1:0] addr_y;\n"
			"output logic [log_memA-1:0]addr_a;\n"
			
			);
		}
		
	else if(p==k)
		{
			fprintf(outfile,"output logic [log_memX-1:0] sel_y;\n");
			for(m=1;m<p+1;m++)
			{
				fprintf(outfile,"output logic wr_en_a%d;\n"
				"output logic [log_memX-1:0]addr_a%d;\n",m,m);
			}
		}
		
	fprintf(outfile,"logic [3:0] state;\n"
	"logic [k:0] i,j,r,q;\n"
	
	"//state changing always ff block\n"
	"always_ff @(posedge clk) begin\n"
		"//to prevent waiting for one clock cycle doing the work in a state we have included the code for execution at the instant we change state.\n"
		
		"//If youre in state 0 or if reset is asserted, move to state 1 and execute its commands\n"	
		"if(reset==1)begin\n"	
			"state<=1;\n"
			"addr_x<=0;\n"
			"wr_en_x<=0;\n");
			
	if(p==1)
		{
			fprintf(outfile,"addr_y<=0;\n"
			"wr_en_a<=0;\n"
			"addr_y<=0;\n"
			"addr_a<=0;\n"
			"wr_en_y<=0;\n"
			"clear_acc<=0;\n"
			"done<=0;\n"
			"i<=0;j<=0;r<=0;q<=0;\n"
			
			
		"end\n"
		
		"else begin\n" 
			"if(loadMatrix==1) begin\n"
			"addr_x<=0;\n"
			"wr_en_x<=0;\n"
			"state<=2;\n"
			"wr_en_a<=1;\n"
			"addr_a <= 0;\n");
			fprintf(outfile,"i<=0;\n"
		"end\n"
		"else if(state==2&&i<k*k)begin\n"
		"addr_a<=i+1;\n"
		"i<=i+1;\n"
		"if(i==k*k-1)begin\n"
		"wr_en_a<=0;\n"
		"end\n"
		"end\n"
		" if(loadVector==1)begin\n"
			"state<=3;\n"
			"addr_x<=0;\n"
			"wr_en_x<=1;\n"
			"addr_a<=0;\n"
			"wr_en_a<=0;\n"
			"i<=0;\n"
			
			
		"end\n"
		"else if (state ==3 && j<k)begin\n"
		"addr_x<=j+1;\n"
		"j<=j+1;\n"
		"if(j==k-1)begin\n"
		"wr_en_x<=0;\n"
		"end\n"
		"end\n"
		" if(start==1)begin //cleares the flipflop and initiates memory addresses to start MAC operation\n"
			"state<=4;\n"
			"addr_x<=0;\n"
			"wr_en_x<=0;\n"
			"addr_a<=0;\n"
			"wr_en_a<=0;\n"
			"clear_acc<=1;\n"
			"j<=1;\n"
			"i<=1;\n"
			"end\n"

			"else if(state==4 || (state==5 && j<k))begin //start reading from matrix A and vector X\n"
			"state<=5;\n"
			"clear_acc<=0;\n"
			"addr_x<=j;\n"
			"addr_a<=i;\n"
			"i<=i+1;\n"
			"j<=j+1;\n"
			"q<=0;\n"
			"end\n"
			
			"else if(state==5&&j==k)begin//wait in state 6 for output of MAC\n"
			"state<=6;\n"
			"j<=0;\n"
			"if(g==1)\n"
			"q<=q+1;\n"
			"end\n"
			
			"else if(state==6&&q==1)begin\n"
			"state<=6;\n"
			"q<=q+1;\n"
			"clear_acc<=0;\n"
			"end\n"
			
			"else if(state==6)begin//writes into memory Y\n"
			"state<=7;\n"
			"addr_x<=j;\n"
			"addr_y<=i/k-1;\n"
			"wr_en_y<=1;\n"
			"clear_acc<=0;\n"
			"end\n"
			
			"else if(state==7)begin\n"
			"if(i<k*k)begin\n"
			"state<=5;//go to five in next state\n"
			"addr_x<=j;\n"
			"addr_a<=i;\n"
			"i<=i+1;\n"
			"j<=j+1;\n"
			"wr_en_y<=0;\n"
			"clear_acc<=1;\n"
			"end\n"
			"else if(i==k*k)begin\n"
			"state<=8;//go to state 8 to start outputting y values\n"
			"r<=r+1;\n"
			"done<=1;//assert done signal\n"
			"addr_y<=r;\n"
			"wr_en_y<=0;\n"
			"end\n"
			"end\n"
			
			"else if(state==8)begin//reads from memory Y\n"
			"state<=9;\n"
			"done<=0;\n"
			"addr_y<=r;\n"
			"r<=r+1;\n"
			"end\n"
			
			"else if(state==9&&r<k)begin\n"
			"addr_y<=r;\n"
			"r<=r+1;\n"
			"end\n"
			
			"else if(r==k)begin //return to state 1 after completing work in state 9\n"
			"state<=1;\n"
			"addr_x<=0;\n"
			"wr_en_x<=0;\n"
			"wr_en_y<=0;\n"
			"clear_acc<=0;\n"
			"done<=0;\n"
			"i<=0;j<=0;q<=0;r<=0;\n"
			"wr_en_a<=0;\n"
			"addr_a<=0;\n"
			"end\n"
			"end\n"
			"end\n"

	
"endmodule\n\n");
		}
		
	else if(p==k)
	{
		fprintf(outfile,"sel_y<=0;\n"
			"wr_en_y<=0;\n"
			"clear_acc<=0;\n"
			"done<=0;\n"
			"i<=0;j<=0;q<=0;r<=0;\n"
			);
			
		for(m=1;m<p+1;m++)
		{
			fprintf(outfile,"wr_en_a%d<=0;\n"
			"addr_a%d<=0;\n",m,m);
		}
		
		fprintf(outfile,"end\n"
		
		"else begin\n"
		"if(loadMatrix==1 || state==2&i<k*k) begin\n"
			"addr_x<=0;\n"
			"wr_en_x<=0;\n"
			"state<=2;\n"
			"if(i<1*k)begin\n"
				"addr_a1 <= i;\n"
				"wr_en_a1<=1;\n"
			"end\n",m+1,m+1,m+1);
		for(m=2;m<p+1;m++)
		{
			fprintf(outfile,"else if(i<%d*k)begin\n"
				"addr_a%d <= i%%%d;\n"//%% to print one %
				"wr_en_a%d<=1;\n"
				"wr_en_a%d<=0;\n"
			"end\n",m,m,k,m,m-1);
		}
		
		
		fprintf(outfile,"i<=i+1;\n"
		"end\n"
		"else if(state==2&&i==k*k)begin\n"
		"wr_en_a%d<=0;\n"
		"end\n",k);
		
		fprintf(outfile,
		"if(loadVector==1||(state ==3 && j<k))begin\n"
			"state<=3;\n"
			"addr_x<=j;\n"
			"wr_en_x<=1;\n"
			);
		
	/* 	for(m=1;m<p+1;m++)
			{
				fprintf(outfile,"wr_en_a%d<=0;\n"
			"addr_a%d <= 0;\n",m,m);
			} */
		
		fprintf(outfile,"i<=0;\n"
			"j<=j+1;\n"
			
		"end\n"
		"else if(state==3&&j==k)begin\n"
		"wr_en_x<=0;\n"
		"end\n"
		" if(start==1)begin //cleares the flipflop and initiates memory addresses to start MAC operation\n"
			"state<=4;\n"
			"addr_x<=0;\n"
			"wr_en_x<=0;\n");
			for(m=1;m<p+1;m++)
		{
			fprintf(outfile,"wr_en_a%d<=0;\n"
			"addr_a%d<=0;\n",m,m);
		}
			fprintf(outfile,"clear_acc<=1;\n"
			"j<=1;\n"
			"end\n"
			
			"else if(state==4 || (state==5 && j<k))begin //start reading from matrix A and vector X\n"
			"state<=5;\n"
			"clear_acc<=0;\n"
			"addr_x<=j;\n"
			"j<=j+1;\n"
			"q<=0;\n");
			
			for(m=1;m<p+1;m++)
			{
				fprintf(outfile,"addr_a%d<=j;\n",m);
			}
			
		fprintf(outfile,"end\n"
			
			"else if(state==5&&j==k)begin//wait in state 6 for output of MAC\n"
			"state<=6;\n"
			"j<=0;\n"
			"if(g==1)\n"
			"q<=q+1;\n"
			"end\n"
			
			"else if(state==6&&q==1)begin\n"
			"state<=6;\n"
			"q<=q+1;\n"
			"clear_acc<=0;\n"
			"end\n"
			
			"else if(state==6)begin//writes into memory Y\n"
			"state<=8;\n"
			"addr_x<=j;\n"
			"wr_en_y<=1;\n"
			
		"end\n"
		"else if(state==8)begin//reads from memory Y\n"
			"state<=9;\n"
			"done<=1;\n"
			"wr_en_y<=0;\n"
			
		"end\n"
		"else if(state==9&&r<k)begin\n"
			"done<=0;\n"
			"sel_y<=r;\n"
			"r<=r+1;\n"
			"end\n"
			"else if (r==k)begin\n"
			"state<=1;\n"
			"addr_x<=0;\n"
			"wr_en_x<=0;\n"
			"sel_y<=0;\n"
			"wr_en_y<=0;\n"
			"clear_acc<=0;\n"
			"done<=0;\n"
			"i<=0;j<=0;q<=0;r<=0;\n"
			);
			
		for(m=1;m<p+1;m++)
		{
			fprintf(outfile,"wr_en_a%d<=0;\n"
			"addr_a%d<=0;\n",m,m);
		}
			fprintf(outfile,"end\n"
				"end\n"
				"end\n"
				"endmodule\n");
	}
	



    fclose(outfile);
 
}



