`timescale 1ps/1ps

// tag::module_source[]
module block_nonblock(
    input Sig,
    output reg A, B, C, D, E, F
);

    // Blocking assignment
    always @(Sig) begin
        A = Sig; // A immediately gets sig
        B = A; // B immediately gets sig
        C = B; // C immediately gets sig
    end
    // In blocking assignment, Verilog will generate
    // circuits that require full propogation of signals
    // until continuing

    // Non-Blocking assignment
    always @(Sig) begin
        D <= Sig; // D immediately gets sig
        E <= D; // E gets D next time
        F <= E; // F gets E next time
    end
    // In non-blocking assignment, Verilog will generate
    // synchronous logic that ends immediately, and does
    // not block until all circuits propogate
    // USE THIS UNLESS YOU KNOW WHAT YOU ARE DOING

endmodule
// end::module_source[]

module test();

    reg Sig;
    wire A, B, C, D, E, F;

    block_nonblock uut(
        .Sig(Sig),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .F(F)
    );

    initial begin
        $dumpvars(0,test);
        Sig = 0;
        #1 Sig = ~Sig;
        #1 Sig = ~Sig;
        #1 Sig = ~Sig;
        #1 Sig = ~Sig;
        #1 Sig = ~Sig;
        #1 Sig = ~Sig;
        #1;
    end

endmodule