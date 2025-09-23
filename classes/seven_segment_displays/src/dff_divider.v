`timescale 1ps/1ps

// tag::dff_impl[]
module dff(
    input reset,
    input clock,
    input D,
    output reg Q,
    output NotQ
);
    assign NotQ = ~Q;

    always @(posedge reset, posedge clock) begin
        if (reset) begin
            Q <= 0;
        end else if (clock) begin
            Q <= D;
        end
    end
endmodule
// end::dff_impl[]

module test();

    integer i;
    reg reset, clock, D;
    wire Q, NotQ;

    dff div(
        .reset(reset),
        .clock(clock),
        .D(NotQ),
        .NotQ(NotQ),
        .Q(Q)
    );

    initial begin
        $dumpvars(0,test);
        reset = 1;
        clock = 0;
        #1;
        reset = 0;
        #1;
        for (i = 0; i < 20; i = i + 1) begin
            #5 clock = ~clock;
        end
        $finish;
    end

endmodule