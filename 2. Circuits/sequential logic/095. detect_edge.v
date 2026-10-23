module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    integer i;
    reg [7:0] prev_in;

    always @(posedge clk) begin
         prev_in <= in;
         pedge <= 0;
        for (i=0;i<8;i++) begin
            if (prev_in[i]==0 & in[i]==1)
                pedge[i]<=1;
        end
       
    end

endmodule

// ** without for **
// reg [7:0] prev_in;

//     always @(posedge clk) begin
//         prev_in <= in;
//         pedge   <= in & ~prev_in;
//     end
