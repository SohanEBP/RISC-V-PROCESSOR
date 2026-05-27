module instruction_module (
    input  wire [63:0] address,     // 64-bit byte address from which instruction is to be fetched
    output reg  [31:0] instruction  // 32-bit instruction output fetched from memory
);

    reg [7:0] mem [0:511];    // 512-byte memory array

    // initialize memory from a file
    initial begin
        $readmemb("ins.txt", mem); // load memory contents from a file
    end

    always @(*) begin
        if (address < 509 ) begin       // check if address is within memory bounds
            instruction = {             
                mem[address],     // msb
                mem[address + 1], 
                mem[address + 2], 
                mem[address + 3]  // lsb
            };
        end
    end
// instruction is being fetched by reading 4 bytes from memory
// starting from the given address
// the 4 bytes are concatenated to form a 32-bit instruction
// the instruction is then stored in the 'instruction' register
// the instruction is then output to the next stage of the pipeline

endmodule