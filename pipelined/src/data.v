// module data_mem (out, add, in, mem_wr, mem_rd, clk);
//     reg [7:0] memory [0:255];   // 512-byte memory array
//     input [63:0] add;            // memory address
//     input [63:0] in;            // data to be written to memory
//     input clk;                  // clock signal
//     input mem_rd,mem_wr;        // memory read and write control signals
//     output reg [63:0] out;      // data read from memory
//     initial $readmemb ("data.txt",memory);      // load memory contents from a file
//     always@(add)
//     begin
//         if ((mem_wr==1 || mem_rd==1) && add>255) begin 
//             $display("Memory out of bounds error at time::%t", $time); //error handling
//             $stop;
//         end
//         else begin
//         if(mem_rd)              // 8 bytes read from memory
//             out <={memory[add],
//                    memory[add+1],
//                    memory[add+2],          
//                    memory[add+3],
//                    memory[add+4],       
//                    memory[add+5],
//                    memory[add+6],       
//                    memory[add+7]};
//         end
//     end
//     always @(posedge clk ) begin
//         if(mem_wr) begin        // 8 bytes written to memory
//             memory[add]=in[63:56];
//             memory[add+1]=in[55:48];
//             memory[add+2]=in[47:40];
//             memory[add+3]=in[39:32];
//             memory[add+4]=in[31:24];
//             memory[add+5]=in[23:16];
//             memory[add+6]=in[15:8]; 
//             memory[add+7]=in[7:0];    
//         end
//     end
// endmodule

module data_mem (out, add, in, mem_wr, mem_rd, clk);
    reg [7:0] memory [0:255];   // 512-byte memory array
    input [63:0] add;            // memory address
    input [63:0] in;            // data to be written to memory
    input clk;                  // clock signal
    input mem_rd,mem_wr;        // memory read and write control signals
    output reg [63:0] out;
    integer i;      // data read from memory
    initial $readmemb ("data.txt",memory);      // load memory contents from a file
    always@(*)
    begin
        if ((mem_wr==1 || mem_rd==1) && add>255) begin 
            $display("Memory out of bounds error at time::%t", $time); //error handling
            $stop;
        end
        else begin
        if(mem_rd)              // 8 bytes read from memory
            out <={memory[add],
                   memory[add+1],
                   memory[add+2],          
                   memory[add+3],
                   memory[add+4],       
                   memory[add+5],
                   memory[add+6],       
                   memory[add+7]};
        end
    end
    always @(negedge clk ) begin
        if(mem_wr) begin        // 8 bytes written to memory
            memory[add]=in[63:56];
            memory[add+1]=in[55:48];
            memory[add+2]=in[47:40];
            memory[add+3]=in[39:32];
            memory[add+4]=in[31:24];
            memory[add+5]=in[23:16];
            memory[add+6]=in[15:8]; 
            memory[add+7]=in[7:0];    
        end
        $display ("Time=%0d", $time);
        for (i=0;i<41;i=i+1) begin
            $display("mem[%0d] = %0d",i,memory[i]);
        end
    end
endmodule