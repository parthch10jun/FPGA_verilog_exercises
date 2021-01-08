module adder4 (S, cout, A, B, cin);
 input [3:0] A, B; input cin;
 output [3:0] S; output cout;
 
 assign {cout, S} = A + B + cin;
endmodule