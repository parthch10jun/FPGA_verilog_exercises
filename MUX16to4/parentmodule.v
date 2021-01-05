module mux16to1( in, sel, out);
 input[15:0] in;
 input [3:0] sel;
 input out;
 wire [3:0] t;

 mux4to1 M0(in[3:0], sel[1:0], t[0]);
 mux4to1 M1(in[7:4], sel[1:0], t[1]);
 mux4to1 M2(in[11:8], sel[1:0], t[2]);
 mux4to1 M3(in[15:12], sel[1:0], t[3]);
 mux4to1 M4(in[t, sel[3:2], out);
endmodule