module top_module(
    input clk,
    input in,
    input reset,
    output done);

    parameter IDLE  = 0, DATA  = 1, STOP  = 2, DONE  = 3, ERROR = 4;
    reg [2:0] state, next_state;
    reg [2:0] cnt;

    always @(*) begin
        case (state)
            IDLE:  next_state = (~in) ? DATA : IDLE;
            DATA:  next_state = (cnt == 7) ? STOP : DATA;
            STOP:  next_state = (in) ? DONE : ERROR;
            DONE:  next_state = (~in) ? DATA : IDLE;
            ERROR: next_state = (in) ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            cnt   <= 0;
        end
        else begin
            state <= next_state;
            if (state == DATA) cnt <= cnt + 1;
            else cnt <= 0;
        end
    end
    assign done = (state == DONE);

endmodule