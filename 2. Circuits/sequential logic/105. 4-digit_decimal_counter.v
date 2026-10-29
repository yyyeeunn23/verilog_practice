module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
	
    wire [3:0] q1,q2,q3,q0;
    counter cnt0(clk, reset, 1 , q0);
    counter cnt1(clk, reset, ena[1], q1);
    counter cnt2(clk, reset, ena[2], q2);
    counter cnt3(clk, reset, ena[3], q3);
    
    assign q ={q3,q2,q1,q0};
    assign ena={(q0==9)&(q1==9)&(q2==9),(q0==9)&(q1==9),(q0==9)};
    
endmodule

module counter(
	input clk,
	input reset,
   	input enable,
	output reg [3:0] q);
	
	always @(posedge clk)
        if (reset) q <= 0;
    else if (enable) begin
        if (q == 9) q <= 0;
        else q <= q+1;
    end
	
endmodule