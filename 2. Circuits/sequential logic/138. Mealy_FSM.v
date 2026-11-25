module top_module (
    input clk,
    input aresetn,
    input x,
    output z ); 

    parameter S0 = 0, S1 = 1, S2 = 2; //S0: initial state, S1: x=1, S2=10;
    reg [1:0] state, next_state;

    always @(*) begin
        case (state)
        S0: next_state = (x==1) ? S1 : S0;
        S1: next_state = (x==0) ? S2 : S1;
        S2: next_state = (x==1) ? S1 : S0;
        default: next_state = S0;
        endcase
    end

    always @(negedge aresetn or posedge clk) begin
        if (~aresetn) state <= S0;
        else state <= next_state;
    end

    assign z = (state==S2) & (x==1);

endmodule