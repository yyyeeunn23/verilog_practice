module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    parameter S0 = 4'd0, S1 = 4'd1, S11 = 4'd2, S110 = 4'd3,
              B0 = 4'd4,B1 = 4'd5, B2 = 4'd6, B3 = 4'd7,
              COUNT =8, DONE =9;


    reg [3:0] delay, state, next_state;
    reg [9:0] q; //1000counter
    reg [3:0] remaining; //남은 1000사이클 구간 수

    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            delay <= 0; q<=0; remaining<=0;
        end
        else begin
            if(state==COUNT&&q!=999) q<=q+1;
                else if(state==COUNT) begin
                    q<=0;
                    remaining <= remaining-1;
                end
                else if(state==B3)begin
                    q<=0;
                    remaining <= {delay[2:0], data};
                end
            state <= next_state;
            if (state==B0||state==B1||state==B2||state==B3)
             delay <= {delay[2:0], data};
        end
    end

    always @(*) begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S11 : S0;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? B0 : S0; //1011 감지 완료
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = COUNT; //4비트 카운트
            COUNT: next_state = (!remaining&&q==999)?DONE:COUNT;
            DONE: next_state = ack? S0:DONE;
        endcase
    end

    assign count = remaining;
    assign counting = (state==COUNT);
    assign done = (state==DONE);
            
endmodule