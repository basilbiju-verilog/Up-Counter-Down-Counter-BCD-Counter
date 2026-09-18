`timescale 1ns / 1ps

module counter_4bit_down_tb;

    reg clk;
    reg reset;
    wire [3:0] q;

    // Instantiate DUT
    counter_4bit_down uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk = 0;
        reset = 1;

        // Hold reset
        #10;

        // Release reset
        reset = 0;

        // Count down
        #160;

        // Test asynchronous reset
        reset = 1;
        #10;

        // Release reset
        reset = 0;

        #30;

        $finish;
    end

endmodule