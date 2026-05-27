module main_wrap_tb;

    // inputs
    reg clk;

    // instantiate the unit under test
    main_wrap uut(
        .clk(clk)
    );

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // toggle clock every 5 time units
    end

    // testbench logic
    initial begin
        // initialize inputs
        $dumpfile("sohan.vcd");
        $dumpvars(0, main_wrap_tb);
        $monitor("Time = %0t | PC = %h | Instruction = %h | ALU Result = %h | Read Data = %h | Write Data = %h | RegWrite = %b | Branch = %b",
                 $time, uut.pc_add, uut.instruct, uut.alu_result, uut.Readdata, uut.write_data, uut.RegWrite, uut.Branch);

        #35; // run for 100 time units

        $finish;
    end

endmodule