`timescale 1ns/1ps

module broken(
    input A,
    output Y
);
    // Here we invert in a very silly way!

    if (A)
        assign Y = 0;
    else if (~A)
        assign Y = 1;
endmodule