`timescale 1ps/1ps

// tag::byte_mem[]
module byte_memory(
    input [7:0] data,
    input store,
    output reg [7:0] memory
);

    // Herein, implement D-Latch style memory
    // that stores the input data into memory
    // when store is high

    // Memory should always output the value
    // stored, and it should only change
    // when store is high

endmodule
// end::byte_mem[]

// tag::mem_system[]
module memory_system(
    input [7:0] data,
    input store,
    input [1:0] addr,
    output [7:0] memory
);

    // This should instantiate 4 instances of
    // byte_memory, and then demultiplex
    // data and store into the one selected by
    // addr

    // It should then multiplex the output of the
    // memory specified by addr into the memory
    // output for display on the LEDs

endmodule
// end::mem_system[]

// tag::top[]
module top(
    input [15:6] sw,
    input btnC,
    output [15:8] led
);

    memory_system mem(
        .data(sw[15:8]),
        .addr(sw[7:6]),
        .store(btnC),
        .memory(led)
    );

endmodule
// end::top[]