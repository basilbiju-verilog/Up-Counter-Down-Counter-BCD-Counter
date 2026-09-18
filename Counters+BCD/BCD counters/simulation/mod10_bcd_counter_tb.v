`timescale 1ns / 1ps

module mod10_bcd_counter_tb;

    reg clk;
    reg reset;
    wire [3:0] q;

    // Instantiate DUT
    mod10_bcd_counter uut (
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

        // Apply reset
        #10;

        // Release reset
        reset = 0;

        // Allow counter to count
        #100;

        // Test reset again
        reset = 1;
        #10;

        reset = 0;

        // Count again
        #30;

        $finish;
    end

endmodule