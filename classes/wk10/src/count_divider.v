`timescale 1ps/1ps

// tag::count_impl[]
module counter
#(
    parameter WIDTH = 8
)
(
    input reset,
    input clock,
    output reg [WIDTH - 1:0] count
);
    always @(posedge reset, posedge clock) begin
        if (reset) begin
            count <= 0;
        end else if (clock) begin
            count <= count + 1;
        end
    end
endmodule
// end::count_impl[]

// tag::divclock_impl[]
module div(
    input clock,
    input reset,
    output reg div_clock
);
    reg intreset;
    wire [16:0] intcount;

    counter #(.WIDTH(17)) count(
        .clock(clock),
        .reset(intreset),
        .count(intcount)
    );

    // Want to create logic that
    // is synchronous to the rest
    // and count signals
    always @(reset, intcount) begin
        if (reset) begin
            // If we get reset, pass it through
            // to the counter
            // and reset out clock output
            intreset = 1;
            div_clock = 0;
        end else if (intcount == 100000) begin
            // Otherwise, if the count is equal
            // to our tickover point, then we
            // need to reset the counter and
            // toggle our output
            intreset = 1;
            div_clock = ~div_clock;
        end else begin
            // Otherwise, just let it count
            intreset = 0;
        end
        
    end

endmodule
// end::divclock_impl[]

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