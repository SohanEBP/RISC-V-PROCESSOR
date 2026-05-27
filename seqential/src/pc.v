module pc_address_generator(
    output reg [63:0] nxt_pc_address,
    input [63:0] pc_add, immd,
    input branch
);

    reg [63:0] nxt_add, jump_add;

    always @(*) begin
        nxt_add = pc_add + 64'd4;
    end

    always @(*) begin
        jump_add = pc_add + (immd << 1);
    end

    // mux to select between nxt_address and jump_address based on branch signal
    always @(*) begin
        if (branch)
            nxt_pc_address = jump_add;
        else
            nxt_pc_address = nxt_add;
    end

endmodule