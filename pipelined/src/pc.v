
module pc_address_generator(
    output reg [63:0] nxt_pc_address,   // next pc value
    input [63:0] pc_add,    // current pc value
    input [63:0] immd,      // immediate value
    input branch            // branch control signal
);

    reg [63:0] nxt_add, jump_add;   // next pc address and jump address

    always @(*) begin
        nxt_add = pc_add + 64'd4;   // increment pc by 4
    end

    always @(*) begin
         jump_add = pc_add + (immd << 1);    // jump to immediate address
    end

    // mux to select between nxt_address and jump_address based on branch signal
    always @(*) begin
        if (branch)
            nxt_pc_address = jump_add;
        else
            nxt_pc_address = nxt_add;
    end

endmodule

