module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    integer i;
    reg [31:0] Q;
    assign q=Q;
    always @(posedge clk) begin
        if (reset) Q <= 32'h1;
        else begin
           Q[31] <= Q[0];
            for (i=30; i>=0; i=i-1) begin
                if(i==21|i==1|i==0)
                    Q[i] <= Q[i+1]^Q[0];
                else Q[i] <= Q[i+1];
            end
        end
    end
            

endmodule