module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
  reg [1:0] level;
    reg direction;
    wire [1:0] current_level;

    assign current_level = s[3] ? 3 :  s[2] ? 2 : s[1] ? 1 : 0;

    always @(posedge clk) begin
        if (reset) begin
            level <= 0;
            direction <= 1;
        end
        else begin
            if (current_level > level)
                direction <= 0;
            else if (current_level < level)
                direction <= 1;
		   level <= current_level;
        end
    end

    always @(*) begin
        fr1 = (level < 3);
        fr2 = (level < 2);
        fr3 = (level < 1);
        dfr = direction;
    end

endmodule
