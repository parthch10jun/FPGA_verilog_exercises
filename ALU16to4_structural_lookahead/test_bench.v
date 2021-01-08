module alutest;
 reg [15:0] X, Y; wire[15:0] Z; wire Si, Ze, Ca, Pa, Ovf;
 ALU DUT(X, Y, Z, Si, Ze, Ca, Pa, Ovf);
 initial
  begin
   $dumpfile ("alu.cd"); $dumpvars (0, alutest);
   $monitor ($time, "X = %h, Y = %h, Z = %h, Si = %b, Ze = %b, Ca = %b, Pa = %b, Ovf = %b", X, Y, Z, Si, Ze, Ca, Pa, Ovf);
   #5 X = 16'h8fff; Y = 16'h8000;
   #5 X = 16'hfffe; Y = 16'h0002;
   #5 X = 16'hAAAA; Y = 16'h5555;
   #5 $finish;
  end
 endmodule
   