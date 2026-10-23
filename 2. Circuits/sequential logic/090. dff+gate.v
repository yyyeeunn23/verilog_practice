module top_module (
    input clk,
    input in, 
    output out);
    
    wire d,q;
    assign d=in^q;
    always @(posedge clk)
        q<=d;
	assign out = q;

    // **without wire**
    //  always @(posedge clk)
    //       out <= in ^ out; 
    
endmodule