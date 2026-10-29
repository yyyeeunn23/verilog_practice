module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always @(posedge clk) begin
        if (reset) q<=0;
        else begin
            if (slowena) begin
                if (q==4'b1001) q<=0;
                else q<=q+1;
            end
        end
    end

// always @(posedge clk) begin
//     if (reset) q <= 0;
//     else if (slowena) q <= (q == 4'b1001) ? 0 : q + 1;
// end

// always @(posedge clk) begin
//         if(reset | (slowena & (q == 9))) q <= 0;
//         else q <= (slowena) ? q + 1 : q; 
//     end

endmodule