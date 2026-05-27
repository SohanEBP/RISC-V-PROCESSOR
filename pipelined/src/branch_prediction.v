module BranchPrediction (
    input Branch,
    input Zero,
    output reg Flush
);
    always @(*) begin
        Flush = Branch && Zero;
    end
endmodule