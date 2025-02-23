// Timescale in delay/resolution format
// This means all delays will be in nanoseconds
// and the resolution of the simulation is in picoseconds
`timescale 1ns/1ps
module test();
    reg sig;
    wire out;

    // Pretend UUT, no module exists
    pretend uut(.sig(sig), .out(out));

    // Simulation starts
    initial begin
        sig = 1;
        #10; // This delays 10 ns
    end
endmodule