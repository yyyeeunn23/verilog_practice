module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    assign Z = Q[{A,B,C}];
    reg [7:0] Q;
    always @(posedge clk) begin
        if (enable) Q <= {Q[6:0], S};
        
    end
        
        
endmodule