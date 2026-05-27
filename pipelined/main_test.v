`include "main.v"
module main_wrap_tb;
    reg clk;
    main_wrap uut(
        .clk(clk)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #3 clk = ~clk; // Toggle clock every 5 time units
    end

    // Testbench logic
    initial begin
        // Initialize the VCD dump file
        $dumpfile("pipeline.vcd");
        $dumpvars(0, main_wrap_tb);


        // // Monitor signals
        // $monitor("Time = %0t | PCC = %h | Instruction = %h | ALU Result = %h | Read Data = %h | Write Data = %h | RegWrite = %b | Branch = %b",
        //          $time, uut.pc_add, uut.instruct, uut.alu_result, uut.readdata, uut.write_data, uut.RegWrite, uut.Branch);

        // Run the simulation for a few clock cycles
        #120; // Run for 100 time units

        $finish;
    end
endmodule