`default_nettype none

module change_selector
    (input  logic       less,
     input  logic       exact,
     input  logic       more,
     input  logic [3:0] change,
     input  logic [1:0] Pentagons,
     input  logic [1:0] Triangles,
     input  logic [1:0] Circles,
     output logic [2:0] FirstCoin,
     output logic [2:0] SecondCoin,
     output logic       ExactAmount,
     output logic       NotEnoughChange,
     output logic       CoughUpMore,
     output logic [3:0] Remaining);

    logic [1:0] PentagonsLeft, TrianglesLeft, CirclesLeft;

    always_comb begin
        // **************************************************************** //
        // I will need to keep track of the coins we have                   //
        // left at our disposal => ex: (if we use a pentagon for First coin //
        // now we have one less pentagon at our disposal for SecondCoin)    //
        // Initialize these counters to the original number of each coin    // 
        PentagonsLeft = Pentagons;
        TrianglesLeft = Triangles;
        CirclesLeft   = Circles;
        // **************************************************************** //

        FirstCoin       = 3'b000;
        SecondCoin      = 3'b000;
        ExactAmount     = 1'b0;
        NotEnoughChange = 1'b0;
        CoughUpMore     = 1'b0;
        Remaining       = 4'd0;

        // 1) If Paid < Cost => flag CoughUpMore
        if (less) begin
            CoughUpMore = 1'b1;
        end
        // 2) Compute Remaining => Paid - Cost
        else begin
            Remaining = change;

            // 3) ExactAmount => Paid == Cost (no change needed)
            if (exact) begin
                ExactAmount = 1'b1;
            end
            else begin
                // 4) Else => choose FirstCoin as largest available coin <= Remaining
                case (1'b1)
                    (Remaining >= 5 && PentagonsLeft > 2'b00): FirstCoin = 3'b101;
                    (Remaining >= 3 && TrianglesLeft > 2'b00): FirstCoin = 3'b011;
                    (Remaining >= 1 && CirclesLeft   > 2'b00): FirstCoin = 3'b001;
                    default:                                   FirstCoin = 3'b000;
                endcase

                // 5) Subtract val of FirstCoin from Remaining
                case (FirstCoin)
                    3'b101:
                    begin
                        Remaining = Remaining - 5;
                        PentagonsLeft = PentagonsLeft - 1;
                    end
                    3'b011:
                    begin
                        Remaining = Remaining - 3;
                        TrianglesLeft = TrianglesLeft - 1;
                    end
                    3'b001:
                    begin
                        Remaining = Remaining - 1;
                        CirclesLeft = CirclesLeft - 1;
                    end
                    default: Remaining = Remaining;
                endcase

                // 6) Choose SecondCoin as largest available coin <= Remaining
                case (1'b1)
                    (Remaining >= 5 && PentagonsLeft > 2'b00): SecondCoin = 3'b101;
                    (Remaining >= 3 && TrianglesLeft > 2'b00): SecondCoin = 3'b011;
                    (Remaining >= 1 && CirclesLeft   > 2'b00): SecondCoin = 3'b001;
                    default:                                   SecondCoin = 3'b000;
                endcase

                // 7) Subtract val of SecondCoin from Remaining
                case (SecondCoin)
                    3'b101:
                    begin
                        Remaining = Remaining - 5;
                        PentagonsLeft = PentagonsLeft - 1;
                    end
                    3'b011:
                    begin
                        Remaining = Remaining - 3;
                        TrianglesLeft = TrianglesLeft - 1;
                    end
                    3'b001:
                    begin
                        Remaining = Remaining - 1;
                        CirclesLeft = CirclesLeft - 1;
                    end
                    default: Remaining = Remaining;
                endcase

                // 8) NotEnoughChange => Remaining > 0 after FirstCoin and SecondCoin
                if (Remaining > 0) begin
                    NotEnoughChange = 1'b1;
                end
            end
        end
    end

endmodule : change_selector
