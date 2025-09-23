module your_first_module(
    input A, // Single bit input -- END EACH LINE with a comma...
    input [5:0] B, // Six bit wide input
    output C, Another, // two single bit outputs (can be done for input too)
    output BitFour, // We can do any name for our outputs
                    // as long as it doesn't have whitespace in it
    output [5:0] D // Six bit wide ouput... without a comma
    // DO NOT PUT A COMMA AFTER THE LAST LIST ENTRY
); // Note this end paren with a semicolon

    assign C = A; // End each assignment with a semicolon

    wire invertC; // Declare local wires.
                  // These are neither inputs or outputs
                  // but can be used locally to hold values

    assign invertC = ~C; // And can be assigned to regularly
    assign Another = invertC; // And used as if they were regular values

    assign D = B; // When vectors match in size,
                  // they can just be directly assigned

    assign BitFour = B[4]; // Or decomposed for single elements

endmodule // No semicolon here for....... reasons