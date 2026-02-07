`default_nettype none
/******      coin_value module      ******\
    This module maps the coin to its val:
    3'b000 -> 0  (no coin)
    3'b001 -> 1  (circle)
    3'b011 -> 3  (triangle)
    3'b101 -> 5  (pentagon)
\******                           ******/
module coin_value 
    (input  logic [2:0] coin,
     output logic [3:0] val);
  always_comb begin
    case (coin)
      3'b000: val = 4'd0;
      3'b001: val = 4'd1;
      3'b011: val = 4'd3;
      3'b101: val = 4'd5;
      default: val = 4'd0;  
    endcase
  end
endmodule : coin_value




