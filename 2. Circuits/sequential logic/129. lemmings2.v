module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT =0, RIGHT =1, FALL_LEFT = 2, FALL_RIGHT =3;
    reg [1:0] state, next;
    
    always @(*) begin
        case (state)
            0: next = ~ground ? 2 : bump_left ? 1 : 0;
            1: next = ~ground ? 3: bump_right ? 0:1;
            2: next =  ground? 0:2;
            3: next = ground? 1:3;
            default: next = LEFT;
        endcase
    end
    
    
    always @(posedge clk, posedge areset) begin
        if (areset) state <= 0;
        else state <= next;
    end
    
    assign aaah = (state==2)|(state==3);
    assign walk_left = (state ==0);
    assign walk_right = (state ==1);
        

endmodule