module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    wire q0, q1, q2;
    dff_mux sub0(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[0]),
        .q_in(q2),
        .Q(q0)
    );
    dff_mux sub1(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[1]),
        .q_in(q0),
        .Q(q1)
    );
    dff_mux sub2(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[2]),
        .q_in(q1^q2),
        .Q(q2)
    );
    assign LEDR = {q2, q1, q0};


endmodule

module dff_mux(
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    wire d;
    assign d = L ? r_in : q_in;
    always @(posedge clk) 
        Q <=d;

endmodule