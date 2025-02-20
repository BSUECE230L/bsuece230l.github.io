module top(
    input [1:0] sw,
    output [1:0] led
);

    assign led = ~sw;

endmodule