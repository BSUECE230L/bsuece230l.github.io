`timescale 1ns/1ps

// tag::module_source[]
module behavioral_sr_latch(
    input Set,
    input Reset,
    output reg Q,
    output NotQ
);

    always @(Set, Reset) begin // <2>
        if (Set)
            Q <= 1; // <3>
        else if (Reset)
            Q <= 0;
    end

    assign NotQ = ~Q; // <1>

endmodule
// end::module_source[]

module test();

    reg Set, Reset;
    wire Q, NotQ;

    behavioral_sr_latch uut(
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