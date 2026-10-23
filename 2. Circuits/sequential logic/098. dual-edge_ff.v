module top_module (
    input clk,
    input d,
    output q
);
    reg [1:0] status;
    
    always @(posedge clk) status[0] <= d;
    always @(negedge clk) status[1] <= d; 

    assign q = clk ? status[0] : status[1];
    
endmodule