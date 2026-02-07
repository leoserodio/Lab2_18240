`default_nettype none

/******      Comparator Module      ******\
    This modules compares paid and cost:
    If paid < cost, less goes high => 
    if paid = cost, exact goes high => 
    if paid > cost, more goes high.
\******                             ******/
module compare_paid_cost (
  input  logic [3:0] paid,
  input  logic [3:0] cost,
  output logic more,
  output logic exact,
  output logic less
);
  always_comb begin
    less  = (paid < cost);
    exact = (paid == cost);
    more = paid > cost;
  end
endmodule : compare_paid_cost
