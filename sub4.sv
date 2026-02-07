`default_nettype none
/******      4-bit Subtractor      ******/
module sub4 
  (input  logic [3:0] a,
   input  logic [3:0] b,
   output logic [3:0] diff);
  always_comb begin
    diff = a - b;
  end
endmodule : sub4
