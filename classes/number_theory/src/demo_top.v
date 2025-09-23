// tag::basic_module[]
module demo1(
    input B, D, // Declare inputs
    output A, C // Declare outputs
);

    // Content of module
    assign C = ~A;
    assign A = ~B & D;

endmodule
// end::basic_module[]

// tag::basic_top[]
module top(
    input [1:0] sw,
    output [1:0] led
);
    // This is an instantiation, not a function call
    // Think of it like plugging in a circuit to a breadboard
    demo1 uut(
        .B(sw[0]),
        .D(sw[1]),
        .A(led[0]),
        .C(led[1])
    );

endmodule
// end::basic_top[]