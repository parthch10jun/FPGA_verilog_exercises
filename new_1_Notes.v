/*Lecture - 6:
	1. C program - LIFO.
	2. C has functions, Verilog has Modules.
	3. When you invoke(call) a module inside a module say M2 inside M1,
	then a copy of module M2 is embedded inside the master module of M1.
	This process is called instantiation. 
	4. Instantiation allows hierarchy. Ripple carry adder -> 4 F.A ->
	Sum and Carry circuit chain -> Gates.
	5. Parallel statements - Statements in Verilog aren't sequential,
	hardware is synthesised parallelly.
	6. 'assign' statement represents continuous assignment, assign var = exp
		assign t1 = a & b;
		t1 is continuously driven;
	7. Whenever a or b (input) changes t1 changes, albeit after a delay
	8. Use 'assign; only with a net type var, LHS cannot be reg, RHS 
	cam contain both reg or net
	9. 
		a)Net:
		1. driven continuously
		2. Value is not stored
		3. models connections between continuous assignments
		and instantiations
		4. default - 1 bit value, default val - z */
		//eg:
			module use_wand(A, B, C, D, f);
				input A, B, C, D;
				output wand f;
				assign f = A & B;
				assign f = C | D;
			endmodule
				//(wand is implied 'and' gate, therefore f = ((A & B) & (C | D))
				//(wor is similiar)
		/*b)Register:
		1. retains the last value assingned to it
		2. often used to represent storage elements*/

/*Lecture - 7:
/*	1. A lot of features that are discussed henceforth are
	simulation specific or synthesis specific, 
	simulation only features make no sense when hardware is being
	synthesised, say we instantiate a gate and specify the delay of
	this gate, this delay value is rendered useless when the gate
	is synthesised since this synthesised gate will have its own delay. 
//	2. time is used for simulation
//	3. reg default value is x
// 	4. 32 bit counter with asynchronous reset:*/
		module simple_counter (clk, rst, count);
			input clk, rst;
			output reg [31:0] count;
			// body
			always @(posedge clk or posedge rst) //note the presence of or posedge rst
			begin
				if (rst)
					count = 32'b0
				else
					count = count + 1
			end
		endmodule
/*	----> this doesn't sync with clock
	5. reg is unsigned
	6. real --> floating point numbers
	7. vectors - multiple bit quantities
	8. vectors --> range[range1:range2], where range1 is
	the MSB, range2 is LSB, n bit width where n is MSB - LSB + 1
	9. range1 will be the starting index, range2 will be the final index
	10. parts of a vector can be sliced and used:*/
		reg [31:0] IR;
		reg [5:0] opcode;
		reg [4:0] reg1, reg2, reg3;
		reg [10:0] offset;
			opcode = IR[31:26];
			reg1 = IR[25:21];
			reg2 = IR[20:16];
			reg3 = IR[15:11];
			offset = IR[10:0];
//	11. Multidim arrays can be declared, eg: 
		reg [31:0] register_bank[15:0]; 16 32 bit registers
// so if I call  register_bank[5] this will display the  32 bit value
// stored in the reg number 5. 
	12. reg[15:0] mem_word[0:1023];/* 1K 16-bit words 
	13. Parameters:
		Paramterized design:: An N-Bit counter */
		module counter (clear, clock, count);
			parameter N = 7;
			input clear, clock;
			output[0:N] count; reg[0:N] count;
			
			always @(negedge clock)
				if (clear)
					count <= 0;
				else
					count <= count + 1;
		endmodule
	// to make it a 16 bit counter, I would just have to modify 
	// N as 15, and that would save me from changing the whole code

Lecture 8:
	1. primitive gates:
		and #5  G(a, b, c, d, e, f);
		/*	 ^    ^  ^  ^  ^  ^  ^   
			 |    |  |  |  |  |  |   
			 |    |  |__|__|__|__|
		      delay  outp    inpt
			 | 
			 |
		only used by simulation tools
		ignored by logic synthesis tools
	2. 'timescale directive - 'timescale <reference_time_unit>/<time_precision>
																		
																			
				(this specifies unit for time measurement)	 (precision to which the delays
															are rounded off during 
															simulation) */
	3. 	'timescale 10ns/1ns
		module exclusive_or (f, a, b);
			input a, b;
			output f;
			wire t1, t2, t3;
			nand #5 m1(t1, a, b); //This means delay is 50ns
		endmodule
/*	4. Positional and explicit association: same order of parameters, versus 
	arbitary order of parameters, chances of errors are less in explicit association
	5. Hardware modelling issues:
		a net data type always maps to 'wire' during synthesis
		whereas reg type maps to a wire or a 'storage cell' 
		depending upon the context. */
		module reg_maps_to_wire (A, B, C, f1, f2); //reg maps to wire here
			input A, B, C;
			output reg f1, f2;
			wire A, B, C;
			always @(A, B, C) //either A or B or C changes their state
			begin 
				f1 = ~(A & B);
				f2 = f1 ^ C;
			end
		endmodule
	//	--------------*******--------------- // 
		module reg_maps_to_what (A, B, C, f1, f2); //reg f2 maps to a latch here
			input A, B, C;
			output reg f1, f2;
			wire A, B, C;
			always @(A, B, C) //either A or B or C changes their state
			begin 					//latch will be enabled then / /
				f1 = ~(A & B);
				f2 = f1 ^ f2;
			end
		endmodule

/*Lecture 9:
	Verilog operators:
	1. Relational operators - operate on numbers and return a boolean val. 
	2. Bitwise Operators 
	3. Reduction operators - accept a single word operand and produce
	a single bit as output; eg:*/
		wire [3:0] x; wire y;
		assign y = &x; //here & is a reduction operator
						//y is assigned as the 'and' of the 4 bits of x
	------------********----------
//	3 b)Another example:
		wire [3:0] a, b, c; wire f1, f2, f3;
		assign a = 4'b0111;
		assign b = 4'b1100;
		assign c = 4'b0100;
		assign f1 = ^a;
		assign f2 = &(a ^ b);
		assign f3 = ^a & ~^b;
		/* here a = 0111, b = 1100, c = 0100, therfore f1 = 0 Xor 1 Xor 1 Xor 1 = 1
		f2 = & (1011) = 0
		f3 = 1 & ~(0) = 1 & 1 = 1
	4. Shift operators: Shift right, shift left, >>, <<, 
	arithmetic shift right >>>, MSB is added when shifting right. 
	so if a negative number is shifted right say: 1100 --> 0110
	if a negative number is shifted arithmetic right then: 1100 -> 1110
	5. conditional operator: cond_expr ? true expr : false expr;
	eg.*/
		assign eq = (~i0 & ~i1) ? 1'b1:
					(~i1 & i0)  ? 1'b0:
					(i1 & ~i0)  ? 1'b0:
					1'b1;
					
//	6. concatenation operator: Joins together bits from two or more 
//	comma separated exp.
		assign f = {a, b};
	//	--------*****-------
		wire [7:0] a;
		wire [7:0] rot, shl, sha;
		assign rot = {a[2:0], a[7:3]};
		// rotate a to right 3 bits; 
		// if a = 10110110 then a[2:0] = 110 and a[7:3] = 10110 therefore rot = 11010110;
		assign shl = {3'b000, a[7:3]}; 
		// shift a to right 3 bits and insert 0 (logic shift);
		assign sha = {3{a[8]}, a[7:3]};
		
/*	7. Replication operator: joins together n copies of an exp m. n{m}
		example: An 8-bit adder description */
		module parallel_adder (sum, cout, in1, in2, cin);
			input [7:0] in1, in2;
			input cin;
			output [7:0] sum;
			output cout;
			//BODY
			assign #20{cout, sum} = in1 + in2 + cin;
		endmodule
//	8. Expression bit-length adjustment:
		wire [7:0] a, b;
		assign a = 8'b00000000;
		assign b = 0;
/*		The first statement assigns an 8-bit value. "00000000", to a.
		The second statement assigns the integer 0 to b.
		Recall that the integer in Verilog is 32 bits and thus 0 is represented
		as "00000000000000000000000000000000". Since b is 8 bits wide, it is truncated to
		"00000000" during the assignment. */
		-----***-----
	//	eg2:
		// shift 0 to MSB of sum1
		assign suml = (a + b) >> 1;
		// shift carry-out of a+b to MSB of sum2
		assign sum2 = (0 + a + b) >> 1; 
		//an alternative to calculate sum2 which is less prone to error:
		wire [8:0] sum_ext;
		assign sum_ext = {1'b0, a} + {1'b0, b};
		assign sum2 = sum_ext[9:1];
/*Lecture 10:
	1. Modeling are of two types: Behavioral and Structural; Behavioral
	serves as the starting point of the design, Say sum is A xor B xor C, 
	and Carry is A or B or C, but Structural modeling deals
	with the hardware implementation eg. To implement carry 4 nand
	gates will be reqd. 
 Lecture 11:

	Structural modeling of Carry Lookahead Adder
	Consider the ith stage in the addition process;
	defining gi = Ai & Bi
	pi = Ai xor Bi
	gi = 1 represents the condition where a carry is generated
	in stage-i independent of the other stages
	pi = 1 represents the condition where input carry Ci. 
	will be propagated to the output carry Ci+1.
	therefore Ci+1 = gi + pi*ci ***A recursive Expression***
	therefore c1 = g0 + c0p0
	c2 = g1 + g0p1 + c0p0p1
	c3 = g2 + g1p2 + g0p1p2 + c0p0p1p2
	c4 = g3 + g2p3 + g1p2p3 + g0p1p2p3 + c0p0p1p2p3
	S0 = p0 Xor c0 since A0 xor B0 xor C0 = p0 xor c0
	S1 = p1 Xor c1
	S2 = p2 Xor c2
	S3 = p3 Xor c3

 Lecture 12:
	1. The assign statements are followed by procedural descriptions.
	2. The 'assign' statements are used to model behavioral descrip-
	tions. eg: */
		module generate_set_of_MUX(a, b, f, sel);
		 input [3:0] a, b;
		 input sel;
		 output [3:0] f;
		 
		 assign f = sel ? a : b; //generates 4 2:1 MUXes with a 
		 // common sel line
		 //conditional operator generates a MUX
		endmodule
	// ------------------------------------
		assign f = (a == 0) ? (c + d) : (c - d);
		//refer to https://imgur.com/zWoprF8
		input in;
		input [0:1] select;
		output [0:3] out;
		
		assign out[select] = in;//variable index 
		//generates a decoder
//	3. generating a D latch:
		module level_sensitive_latch (D, Q, En);
	 	 input D, En;
		 output Q;
	     // Q will remain Q if En is false
		 assign Q = En ? D : Q;
		endmodule
//	4. generating SR latch:
		 module sr_latch (Q, Qbar, S, R);
		  input S, R;
		  output Q, Qbar;
		  
		  assign Q = ~(R & Qbar);
		  assign Qbar = ~(S & Q);
		 endmodule
/* Lecture 13:
	1. initial statement is not to be used in synthesis but only in simulation.
	2. If there are multiple "initial blocks", all the blocks start
	concurrently
	3. statements start at time = 0 and execute only once. */
	module testbench_example;
	 reg a, b, cin, sum, cout;
	 initial
	  cin = 1'b0
	  
	 initial
	  begin
	   #5 a = 1'b1; b = 1'b1;
	   #5 b = 1'b0;
	  end
	 
	 initial
	  #25 $finish;
	endmodule 
/*  4. "initial" and "always" blocks coexist within the same verilog
	module
	5. They all execute concurrently; "initial" only once and
	"always" repeatedly. */
	 module generating_clock;
	  output reg clk;
	  
	  initial
	   clk = 1'b0; //initialised to 0 at time = 0
	  
	  always
	   #5 clk = ~clk;
	   
	  initial
	   #500 $finish;
	 
	 endmodule
	
//	6. in always statements for eg: 
		always @ (---)
		 begin
		  a = b + c;
		  d = b + 2;
		 end
//		a and d must be 'reg' since when @ condition is false
	//	reg will store the previous values.
//	7. casex and casez:
//      the casez statement treats all z values as don't cares.
//		the casex statement treats all x and z values as don't cares.
		reg[3:0] state; integer next_state;
		casex (state)
		 4'b1xxx : next_state = 0;
		 4'bx1xx : next_state = 1;
		 4'bxx1x : next_state = 2;
		 4'bxxx1 : next_state = 3;
		 default : next_state = 0;
		endcase
		//if state is 4'b01zx the second exp will match, next_state
		//will be 1
/*Lecture 14:
	1. "repeat" loop executes the loop a fixed number of times. */
		  repeat (<expresion>)
			sequential_statement;
	//	if the expression is variable, it is only evaluated
	//	at the start of the execution, doesn't matter if it is
	//	changed mid-execution.
/*	2. The "forever" construct foes not use any expression
	and executes forever until $finish is encountered in test bench.
	3. remember to use time delay in forever construct otherwise
		time doesn't move forward while the block endlessly repeats */
		reg clk;
		initial
		begin
			clk = 1'b0;
			forever #5 clk = ~clk; //clock period of 10 units
		end 
/*	4. @(in) //in changes
	   @(a or b or c) //any of a or b or c changes
	   @(a, b, c) //--do--
	   @(posedge clk) //positive edge of "clk" or clk changes from
	   // 0 to 1 or 0 to (x, z) or (x, z) change to 1.
	   @(*) //any var changes
	5. synchronous set or reset means that changes take place at the
		active edge of the clock. 
		set _____|¯¯¯¯¯¯¯¯¯|_______
		clk(d)__|¯¯¯¯|____|¯¯¯¯|______
				     ↑         ↑
				set Q = 1     set = 0
	6. latch with enable: */
		module latch (q, qbar, din, enable);
		 input din, enable;
		 output reg q, output qbar;
		 
		 assign qbar = ~q;
		 
		 always @ (din or enable)
			begin 
			if (enable) q = din;
			end
		endmodule
/*
Lecture 15: 
	1. 2to1 MUX: */
		module mux21 (in1, in0, s, f);
			input in1, in0, s;
			output reg f;
			
			always @ (in1, in0, s) // or always @(*)
				if(s)
					f = in1;
				else
					f = in0;
		endmodule
//	2.  negedge D flipflop:
		module dff_negedge(D, clock, Q, Qbar);
			 input D, clock;
			 output reg Q, Qbar;
			 
			 always @(negedge clock)
			  begin
			   Q = D
			   Qbar = ~D
			  end
		endmodule
//	3. 4 - bit counter with asynchronous reset
		module counter (clock, reset, count);
			input clock, reset;
			output reg[3:0] count;
			
			always @(posedge clock or posedge reset)
			begin
				if (reset)
					count <= 0;
				else
					count <= count  + 1;
			end
		
		endmodule
// 4. A seemingly combinational but surprisingly sequential logic:
		module incomp_state_spec (curr_state, flag);
			input [0:1] curr_state;
			output reg [0:1]flag;
			
			always @ (curr_state)
			begin
				//flag = 0 to make it combinational
				case (curr_state)
					0,1 : flag = 2;
					3   : flag = 0;
				endcase
		endmodule //latch will be generated since curr_state = 2
					//condition is not specified so it is assumed
				// that flag will remain 2, for that a storage element
				//is required
// 	5. 
		module xyz(input a, b, c, output reg f)
			always @(*)
				if(a == 1)
					f = b & c; //D latch where D = b & c and en = a
		endmodule
	//____________________________________________
		module xyz(input a, b, c, output reg f)
			always @(*)
			begin
				f = c;
				if (a == 1)
					f = b & c; //2:1 MUX with first input as b & c,
								//other as c, sel = a, output = f
			end
		endmodule
		
//	6. 
		module ALU_4bit(input [1:0] op, input [7:0] a, input [7:0] b,
			output reg [7:0] f);
			parameter ADD = 2'b00, SUB = 2'b01, MUL = 2'b10, DIV = 2'b11;
			
			always @ (*)
				case (op)
					ADD : f = a + b;
					SUB : f = a - b;
					MUL : f = a * b;
					DIV : f = a / b;
			 endcase
		endmodule