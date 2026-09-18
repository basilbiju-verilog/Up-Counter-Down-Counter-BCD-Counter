module counter_4bit_down (
    input  wire       clk,
    input  wire       reset,
    output reg  [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b1111;
    else
        q <= q - 1'b1;
end

endmodule