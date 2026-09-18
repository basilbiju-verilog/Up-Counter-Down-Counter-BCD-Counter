module mod10_bcd_counter (
    input  wire       clk,
    input  wire       reset,
    output reg  [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0000;
    else if (q == 4'b1001)
        q <= 4'b0000;
    else
        q <= q + 1'b1;
end

endmodule