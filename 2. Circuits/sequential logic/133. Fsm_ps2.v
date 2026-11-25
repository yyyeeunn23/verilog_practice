module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
	reg [1:0] state, next_state;
    parameter S0 = 0, S1 = 1, S2 = 2, DONE = 3;
    
    always @(*) begin
        case (state)
			 S0: begin
                 if (in[3]) next_state = S1;
                else next_state = S0;
            end
            S1: next_state = S2;
            S2: next_state = DONE;
            DONE: begin
                if (in[3]) next_state = S1;
                else       next_state = S0;
            end
            default: next_state = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) state <= S0;
        else  state <= next_state;
    end
    assign done = (state == DONE);
        

endmodule