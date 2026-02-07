`default_nettype none

module change_maker_updated
  (input  logic [3:0] Cost,
   input  logic [1:0] Pentagons,
   input  logic [1:0] Triangles,
   input  logic [1:0] Circles,
   input  logic [3:0] Paid,
   output logic [2:0] FirstCoin,
   output logic [2:0] SecondCoin,
   output logic [3:0] Remaining,
   output logic       ExactAmount,
   output logic       NotEnoughChange,
   output logic       CoughUpMore);

  logic less, exact, more;
  logic [3:0] change;

  compare_paid_cost cmp(
    .paid(Paid),
    .cost(Cost),
    .more(more),
    .exact(exact),
    .less(less)
  );

 
  sub4 sub(
    .a(Paid),
    .b(Cost),
    .diff(change)
  );

  // change logic
  change_selector sel(
    .less(less),
    .exact(exact),
    .more(more),
    .change(change),
    .Pentagons(Pentagons),
    .Triangles(Triangles),
    .Circles(Circles),
    .FirstCoin(FirstCoin),
    .SecondCoin(SecondCoin),
    .Remaining(Remaining),
    .ExactAmount(ExactAmount),
    .NotEnoughChange(NotEnoughChange),
    .CoughUpMore(CoughUpMore)
  );

endmodule : change_maker_updated
