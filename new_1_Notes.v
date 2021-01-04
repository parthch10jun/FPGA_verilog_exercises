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
		module counter (clearr, clock, count);
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
													|					|
													|					|	
							this specifies unit for time measurement	|--> precision to which the delays
																			are rounded off during 
																				simulation */
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