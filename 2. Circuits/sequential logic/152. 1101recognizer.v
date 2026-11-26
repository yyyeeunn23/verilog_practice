module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    parameter A=0, B=1, C=2, D=3, DONE=4;
    reg [2:0] state, next_state;
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end

    always @(*) begin
        case(state)
        A: next_state=data?B:A;
        B: next_state=data?C:A;
        C: next_state=!data?D:C;
        D: next_state= data?DONE:A;
        DONE: next_state=DONE;
    endcase
    end
    assign start_shifting = (state == DONE);
    
endmodule