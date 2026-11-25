module top_module(
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done);

    parameter IDLE  = 0, DATA  = 1, STOP  = 2, DONE  = 3, ERROR = 4;
    reg [2:0] state, next_state;
    reg [3:0] cnt;
    reg [7:0] data;
    reg odd_reg;
    wire odd, p_reset;

    assign p_reset = reset | (state == IDLE) | (state == DONE);

    parity u_parity (
        .clk   (clk),
        .reset (p_reset),
        .in    (in),
        .odd   (odd)
    );

    always @(*) begin
        case (state)
            IDLE:  next_state = (~in) ? DATA : IDLE;
            DATA:  next_state = (cnt == 8) ? STOP : DATA;
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
            data <= 0;
            odd_reg <= 0;
        end
        else begin
            state <= next_state;
            if (state == DATA) begin
                cnt <= cnt + 1;
                if (cnt < 8) data <= {in, data[7:1]};
            end
            else cnt <= 0;
        if (state == STOP) odd_reg <= odd;
        end
    end
    assign done = (state == DONE)&odd_reg;
    assign out_byte = data;

endmodule