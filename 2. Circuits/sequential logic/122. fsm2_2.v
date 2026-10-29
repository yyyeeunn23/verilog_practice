module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        if (reset) next_state = OFF;
        else case (state)
            OFF: next_state = (j==1)?ON:OFF;
            ON: next_state = (k==1)?OFF:ON;
        endcase
    end

    always @(posedge clk) begin
        state <= next_state;
    end

  assign out = (state==ON);

endmodule