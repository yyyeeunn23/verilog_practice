module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output z
);

    parameter A=0, B=1;
    reg [1:0] state, next_state;
    reg [1:0] cnt; // 1 확인 count
    reg [1:0] cnt0; // 3클럭 세는 count

    always @(posedge clk) begin
        if(reset) begin
            state <= A;
            cnt <=0;
            cnt0 <=0;
        end
        else begin 
            state <= next_state;
        if(state==B) begin
            if(cnt0==3) begin
                cnt <= w;
                cnt0 <= 1;
            end
            else begin
                if(w==1) 
                cnt <= cnt + 1;
                cnt0 <= cnt0 + 1;
            end
        end
    end
    end

    always @(*) begin
        case(state)
        A: next_state = s?B:A;
        B: next_state = B;
        endcase
    end

    assign z = (state==B) & (cnt0==3) & (cnt==2);

endmodule