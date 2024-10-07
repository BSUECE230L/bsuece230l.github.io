`timescale 1ns/1ps

module teaser(
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] Y
);

    always @(*)
        Y = A + B; // Boom. 32 bit adder.

endmodule

module test();

    reg [31:0] A;
    reg [31:0] B;
    wire [31:0] Y;

    teaser uut(
        .A(A),
        .B(B),
        .Y(Y)
    );

    initial begin
        $dumpvars(0,test);
        A = 0;
        B = 0;
        #10;
        A = 1024;
        B = 2048;
        #10;
        $finish;
    end

endmodule