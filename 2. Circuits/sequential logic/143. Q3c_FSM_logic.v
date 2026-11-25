module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

    assign Y0 = ((y == A) && (x == 1)) ||
                ((y == B) && (x == 0)) ||
                ((y == C) && (x == 1)) ||
                ((y == D) && (x == 0)) ||
                ((y == E) && (x == 0));

    assign z = (y == D) || (y == E);

endmodule