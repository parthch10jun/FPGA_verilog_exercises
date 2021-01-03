module binary_decoder
	(
	input wire A0, A1,
	output wire D0, D1, D2, D3
	);
	
	assign D0 = ~A0 & ~A1;
	assign D1 = A0 & ~A1;
	assign D2 = ~A0 & A1;
	assign D3 = A0 & A1;

endmodule
	
	