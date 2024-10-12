`timescale 1ns/1ps

// tag::module_source[]
module behavioral_sr_latch(
    input Set,
    input Reset,
    output reg Y,
    output NotY
);

    always @(Set, Reset) begin
        if (Set)
            Y = 1;
        else if (Reset)
            Y = 0;
    end

    assign NotY = ~Y;

endmodule
// end::module_source[]

module test();

    reg Set, Reset;
    wire Y, NotY;

    behavioral_sr_latch uut(
        .Set(Set),
        .Reset(Reset),
        .Y(Y),
        .NotY(NotY)
    );

    initial begin
        $dumpvars(0,test);
        Reset = 1;
        Set = 0;
        #10;
        Reset = 0;
        #10
        Set = 1;
        #10;
        Set = 0;
        #10;
        $finish;
    end

endmodule