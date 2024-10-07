`timescale 1ns/1ps

module better(
    input A,
    output reg Y // <3>
);
    // Here we invert in a very silly way!
    // but right this time!

    always @(A) begin // <1>
        if (A) // <2>
            Y = 0;
        else if (~A)
            Y = 1;
    end
endmodule

module test();

    reg A;
    wire Y;

    better uut(
        .A(A),
        .Y(Y)
    );

    initial begin
        $dumpvars(0,test);
        A = 0;
        #10;
        A = 1;
        #10;
        $finish;
    end

endmodule