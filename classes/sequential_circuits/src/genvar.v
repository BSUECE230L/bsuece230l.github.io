`timescale 1ps/1ps

// tag::module_source[]
module sample(
    input X, output Y
);
    assign Y = ~X;
endmodule

module genvar_example
#(
    parameter BIT_COUNT = 16 // <6>
)
(
    input [BIT_COUNT - 1:0] sw,
    output [BIT_COUNT - 1:0] led
);

    genvar i; // <1>
    generate // <2>
        for (i = 0; i < BIT_COUNT; i = i + 1) begin // <3>
            sample inst( // <4>
                .X(sw[i]), // <5>
                .Y(led[i])
            );
        end
    endgenerate
endmodule
// end::module_source[]

// tag::module_instance[]
module test();
    reg [15:0] sw;
    wire [15:0] led;

    genvar_example #(.BIT_COUNT(16)) uut( // <1>
        .sw(sw),
        .led(led)
    );

    initial begin
        $dumpvars(0,test);
        sw = 0;
        #10;
        sw = 'hFFFF;
        #10;
    end
endmodule
// end::module_instance[]