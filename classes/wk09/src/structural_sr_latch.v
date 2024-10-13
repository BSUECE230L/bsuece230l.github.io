`timescale 1ns/1ps

// tag::module_source[]
module structural_sr_latch(
    input Set,
    input Reset,
    output Q,
    output NotQ
);

    assign Q = ~(Reset | NotQ);
    assign NotQ = ~(Set | Q);

endmodule
// end::module_source[]

module test();

    reg Set, Reset;
    wire Q, NotQ;

    structural_sr_latch uut(
        .Set(Set),
        .Reset(Reset),
        .Q(Q),
        .NotQ(NotQ)
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