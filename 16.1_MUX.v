// A 16:1 MUX has 4 select lines, that is log2(16) select lines.
// a) Using pure behavioral modeling
// b) Structural modeling using 4:1 MUX specified using behavioral modelling 
// c) Make Structural modeling of 4:1 MUX using behavioral modeling of 2:1 MUX
// d) Make structural modeling of 2:1 MUX to have a complete structural
// hierarchial description. 
//Version_1:
	module mux16to1 (in, sel, out);
		input [15:0] in;
		input [3:0] sel;
		output out;
		
		//body
		assign out = in[sel]; //interesting to note that sel can store a 4 bit value
		//that 4 bit value can store numbers from 0 to 15, and that's 
		// what we want to do when we select input lines
		// which are from 0 to 15. So, in[sel] is selecting an input
		// line from 0 to 15 and giving that to the output. 
	endmodule