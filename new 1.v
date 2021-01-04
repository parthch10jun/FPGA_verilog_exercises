Lecture - 6:
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
		4. default - 1 bit value, default val - z
		eg:
			module use_wand(A, B, C, D, f);
				input A, B, C, D;
				output wand f;
				assign f = A & B;
				assign f = C | D;
			endmodule
				(wand is implied 'and' gate, therefore f = ((A & B) & (C | D))
				(wor is similiar)
		b)Register:
		1. retains the last value assingned to it
		2. often used to represent storage elements

Lecture - 7:
	1. A lot of features that are discussed henceforth are
	simulation specific or synthesis specific, 
	simulation only features make no sense when hardware is being
	synthesised, say we instantiate a gate and specify the delay of
	this gate, this delay value is rendered useless when the gate
	is synthesised since this synthesised gate will have its own delay. 
	2. time is used for simulation
	3. reg default value is x
	4. 32 bit counter with asynchronous reset:
		module simple_counter (clk, rst, count);
			input clk, rst;
			output reg [31:0] count;
			// body
			
	 