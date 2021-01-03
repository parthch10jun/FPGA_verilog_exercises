module greater_than
	(
	input wire A, B,
	output wire C);
	//body
	assign C = A & ~ B;

endmodule