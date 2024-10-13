`timescale 1ps/1ps

// tag::module_source[]
module arrays();

    // Traditional vector:
    wire [7:0] vect; // <1>

    // Array:
    wire arr[3:0]; // <2>

    // Array of vectors:
    wire [7:0] arr_vec[3:0]; // <3>

// tag::access_example[]
    // Single signal:
    assign arr[2] = 'b1; // <1>

    // Single signal:
    assign arr_vec[3] = 8'b10100101; // <2>

    // Single bit of single signal:
    assign arr_vec[2][7] = 1; // <3>
// end::access_example[]

endmodule
// end::module_source[]