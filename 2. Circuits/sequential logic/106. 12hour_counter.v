module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end

        else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00;
                if (mm == 8'h59) begin
                    mm <= 8'h00;
                    if (hh == 8'h11) begin
                        hh <= 8'h12;
                        pm <= ~pm;
                    end // ena일 때 시간 늘어남
                    else if (hh == 8'h12) hh <= 8'h01; // 12시 -> 1시
                    else if (hh[3:0] == 4'd9) begin
                        hh[7:4] <= hh[7:4] + 1'b1;
                        hh[3:0] <= 4'd0;
                    end // 9시 -> 10시
                    else hh[3:0] <= hh[3:0] + 1'b1; // 시간 일의 자리 증가
                end
                else if (mm[3:0] == 4'd9) begin
                    mm[7:4] <= mm[7:4] + 1'b1;
                    mm[3:0] <= 4'd0;
                end //59분 -> 00분
                else mm[3:0] <= mm[3:0] + 1'b1; // 분 일의 자리 증가
            end // 59초 -> 00초

            else if (ss[3:0] == 4'd9) begin
                ss[7:4] <= ss[7:4] + 1'b1;
                ss[3:0] <= 4'd0;
            end // 59초 -> 00초

            else begin
                ss[3:0] <= ss[3:0] + 1'b1;
            end // 초 일의 자리 증가

        end
    end

endmodule