module registerfile (
    input [4:0] Read1, Read2, // addresses of registers to be read
    input [4:0] WriteReg,   // address of register to be written
    input [63:0] WriteData, // data to be written to the register         
    input RegWrite,         // write enable control signal
    input clk,                 
    output [63:0] Data1, Data2      // data read from the registers       
);
    
    reg [63:0] RF [31:0];  // 32 registers, 64-bit each
    
    reg [63:0] tempData1, tempData2;
    integer i;
    integer k;
    initial begin
        for (k = 0; k < 32; k = k + 1) begin    // initialize all registers to 0
            RF[k] = 64'd0;                      
        end
    end

    always @(*) begin       // read data from register file
        tempData1 = RF[Read1];
        tempData2 = RF[Read2];
    end

    assign Data1 = tempData1;       // assign read data to output
    assign Data2 = tempData2;       

    always @(negedge clk) begin   // writing data to register file on posedge clock
        if (RegWrite) 
            RF[WriteReg] <= WriteData;
        
        

        $display("\nTime = %0t", $time);
        for (i = 0; i < 32; i = i + 1) begin
            $display("Reg[%0d]: %0d", i, RF[i]);
        end
    end

    // task print_registers;
    //     integer i;
    //     begin
    //         $display("--- Register File Contents ---");
    //         for (i = 0; i < 32; i = i + 1) begin
    //             $display("RF[%0d] = %h", i, RF[i]);
    //         end
    //         $display("------------------------------");
    //     end
    // endtask


endmodule
