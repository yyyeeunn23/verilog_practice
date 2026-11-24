module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;

    always @(*) begin
        next_state = state;
        if ((bump_left&walk_left)|(bump_right&walk_right))
            next_state = ~state;
    end

    always @(posedge clk, posedge areset) begin
        if(areset) state <= 0;
        else state <= next_state;
    end

    assign walk_left = (state == 0);
    assign walk_right = (state == 1);

endmodule