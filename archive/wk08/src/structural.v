`timescale 1ns/1ps

module structural(
    input [3:0] IN,
    output Y
);

    assign Y = IN[0] ^ IN[1]
                 ^ IN[2] ^ IN[3];

endmodule

module test();

    reg [3:0] in;
    wire y;

    structural uut(
        .IN(in),
        .Y(y)
    );

    initial begin
        $dumpvars(0,test);
        in = 'b0000;
        #10;
        in = 'b1000;
        #10;
        in = 'b1100;
        #10;
        in = 'b1011;
        #10;
    end

endmodule