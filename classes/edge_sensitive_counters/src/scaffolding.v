`timescale 1ps/1ps

// tag::clock_div[]
// clock_div.v
module clock_div
#(
    parameter DIVIDE_BY = 17 // Or 100,000 if you are using counter divider
)
(
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
    
    // IMPORTANT NOTE!! If you do a counter based divider, make sure to only
    // divide clock by 2 during test bench runs or your tests will fail. This
    // will automatically happen for you if you use 2^N divider and the
    // BIT_COUNT parameter

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
    // 0: Right
    // 1: Right Center
    // 2: Left Center
    // 3: Left

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
    //      'b1110: selected_sig <= A
    //      'b1101: selected_sig <= B
    //      ...
    //   endcase

    // You will also need a very simple decoder that assigns the segs components
    // based on the 4 bit input number to hexidecimal digit

    // For reference:
    always @(*) begin
        case(selected_sig)
            //            GFEDCBA
            0: segs  = 7'b1000000;        
            1: segs  = 7'b1111001;        
            2: segs  = 7'b0100100;        
            3: segs  = 7'b0110000;        
            4: segs  = 7'b0011001;        
            5: segs  = 7'b0010010;        
            6: segs  = 7'b0000010;        
            7: segs  = 7'b1111000;        
            8: segs  = 7'b0000000;
            9: segs  = 7'b0010000;        
            10: segs = 7'b0001000;        
            11: segs = 7'b0000011;        
            12: segs = 7'b1000110;        
            13: segs = 7'b0100001;        
            14: segs = 7'b0000110;        
            15: segs = 7'b0001110;       
        endcase
    end

endmodule
// end::seven_seg_decoder[]

// tag::top[]
// top.v
module top
#(
    parameter DIVIDE_BY = 17 // Use this when passing in to your clock div!
    // The test bench will set it to 2 when testing
)
(
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