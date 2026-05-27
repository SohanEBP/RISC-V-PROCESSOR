module instruction_module (
    input  wire [63:0] address,     // 64-bit byte address input
    output reg  [31:0] instruction  // 32-bit instruction output
);

    // 512-byte memory array
    reg [7:0] mem [0:255];

    // initialize memory from a file
    initial begin
        $readmemb("ins.txt", mem); // load memory contents from a file
    end

    always @(*) begin
        if (address < 512 ) begin
            instruction = { 
                mem[address],     // msb
                mem[address + 1], 
                mem[address + 2], 
                mem[address + 3]  // lsb
            };
        end
    end

endmodule