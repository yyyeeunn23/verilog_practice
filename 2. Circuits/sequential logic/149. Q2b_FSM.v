module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    parameter A  = 4'd0, // 리셋 대기
              B  = 4'd1, // f = 1 출력 (1클럭)
              C  = 4'd2, // x 탐색 시작
              D  = 4'd3, // x = 1 감지됨
              E  = 4'd4, // x = 1, 0 감지됨
              F  = 4'd5, // g = 1 시작 & y 첫 번째 체크
              G  = 4'd6, // g = 1 유지 & y 두 번째 체크
              H  = 4'd7, // 영구 g = 1 (성공)
              I  = 4'd8; // 영구 g = 0 (실패)
reg [3:0] state, next_state;

always @(posedge clk) begin
    if (!resetn) state <= A;
    else state <= next_state;
end

always @(*) begin
    case(state)
    A : next_state = resetn?B:A;
    B : next_state = C;
    C : next_state = x? D:C;
    D : next_state = !x? E:D;
    E : next_state = x? F:C;
    F : next_state = (y==1)? H:G;
    G : next_state = (y==1)? H:I;
    H : next_state = H;
    I : next_state = I;
    endcase
end

assign f = (state==B);
assign g = (state==F)||(state==G)||(state==H);
endmodule