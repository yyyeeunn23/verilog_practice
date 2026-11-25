module top_module(
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] cnt;
    reg disc_reg, flag_reg;
    
    always @(posedge clk) begin
        if (reset) begin
            disc_reg <= 0;
            flag_reg <= 0;
            cnt      <= 0;
        end
        else begin
            if (in) begin
                if (cnt < 7) cnt <= cnt + 1;
                disc_reg <= 0;
                flag_reg <= 0;
            end
            else begin
                cnt      <= 0;
                disc_reg <= (cnt == 5);  
                flag_reg <= (cnt == 6);
            end
        end
    end
    
    assign disc = disc_reg;
    assign flag = flag_reg;
    assign err  = (cnt == 7);
endmodule