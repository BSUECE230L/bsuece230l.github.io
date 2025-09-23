module invert_input(
    input A,
    output NotA
);

    assign NotA = ~A;

endmodule

module top(
    input [1:0] sw,
    input [2:0] led
);

    // We can even have more than one of the same module!
    invert_input first( // Instantiate an invert_input named first
        .A(sw[0]), // Hook up its A to sw[0]
        .NotA(led[0]) // and its B to led[0]
    );

    invert_input first( // Instantiate an invert_input named second
        .A(sw[1]), // Hook up its A to sw[1]
        .NotA(led[1]) // and its B to led[1]
    );

    // And to use a signal between them, if required:
    wire inverted;
    invert_input contrived(
        .A(sw[0]),
        .NotA(inverted) // Hook up its output to our new wire instead
    );

    invert_input example(
        .A(inverted), // Use the output from the previous instance
        .NotA(sw[2]) // and send it wherever you need
    );

endmodule