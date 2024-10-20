`timescale 1ps/1ps

// tag::clock_div[]
// clock_div.v
module clock_div(
    input clock,
    input reset,
    output reg div_clock
);

    // 100 MHz input clock Divide by either 2^17 or use a counter based divider
    // to output to div_clock

    // Use the reset signal to set the initial state of your div_clock as well
    // as reset whatever div method you are using

    // If you use the 2^N divider, try instantiating the flip flops with a
    // genvar and generate block

    // If you use the counter block, try using parameters in the counter module
    // to specify the number of bits

endmodule
// end::clock_div[]

// tag::math_block[]
// math_block.v
module math_block(
    input [3:0] A,
    input [3:0] B,
    output reg [3:0] AplusB,
    output reg [3:0] AminusB
);

    // This one should be relatively easy.  You can either use your previous
    // four bit adders and two's compliment converters that you implemented in
    // previous labs, or set up some behavioral verilog to do the job for you

endmodule
// end::math_block[]

// tag::seven_seg_scanner[]
// seven_seg_scanner.v
module seven_seg_scanner(
    input div_clock,
    input reset,
    output reg [3:0] anode
);

    // This block should count through from zero to three, and only activate one
    // anode at a time in the seven segment displays. Keep in mind THEY ARE
    // INVERSE DRIVE, that is that 0 is on 1 is off

    // The reset line should set things back to segment 0

    // Anodes are:
    // 0: R
    // 1: RC
    // 2: LC
    // 3: L

endmodule
// end::seven_seg_scanner[]

// tag::seven_seg_decoder[]
// seven_seg_decoder.v
module seven_seg_decoder(
    input [3:0] A,
    input [3:0] B,
    input [3:0] AplusB,
    input [3:0] AminusB,
    input [3:0] anode,
    output reg [6:0] segs
);

    // This module should be purely combinatorial -- no reset required. What we
    // are going to do here is simply display the correct four bit number
    // according to the table provided in the lab deliverables section

    // Recommended you do a simple behavioral implementation:
    // alwyas @(*) begin
    //   case (anode)
    //      'b1110: A
    //      'b1101: B
    //      ...
    //   endcase

    // You will also need a very simple decoder that assigns the segs components
    // based on the 4 bit input number to hexidecimal digit

    // For reference:
    // 0 -> A, B, C, D, E, F
    // 1 -> B, C
    // 2 -> A, B, G, E, D
    // 3 -> A, B, G, C, D
    // 4 -> F, G, B, C
    // 5 -> A, F, G, C, D
    // 6 -> A, F, G, E, D, C
    // 7 -> A, B, C
    // 8 -> A, B, C, D, E, F, G
    // 9 -> A, B, G, F, C, D
    // A -> A, B, C, G, F, E
    // b -> F, G, C, D, E
    // C -> A, F, E, D
    // d -> B, G, E, D, C
    // E -> A, F, G, E, D
    // F -> A, F, G, E

endmodule
// end::seven_seg_decoder[]

// tag::top[]
// top.v
module top(
    input [7:0] sw, // A and B
    input clk, // 100 MHz board clock
    input btnC, // Reset
    output [3:0] an, // 7seg anodes
    output [6:0] seg // 7seg segments
);

    // Instantiate the clock divider...
    // ... wire it up to the scanner
    // ... wire the scanner to the decoder

    // Wire up the math block into the decoder

    // Do not forget to wire up resets!!

endmodule
// end::top[]