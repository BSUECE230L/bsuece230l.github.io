`timescale 1ps/1ps

// tag::module_source[]
module demultiplexer(
    input [3:0] data,
    input [1:0] sel,
    output reg [3:0] A,
    output reg [3:0] B,
    output reg [3:0] C,
    output reg [3:0] D
);

    always @(*) begin // <1>
        case(sel)
            2'b00: {D, C, B, A} <= {4'b0, 4'b0, 4'b0, data}; // <2>
            2'b01: {D, C, B, A} <= {4'b0, 4'b0, data, 4'b0};
            2'b10: {D, C, B, A} <= {4'b0, data, 4'b0, 4'b0};
            2'b11: {D, C, B, A} <= {data, 4'b0, 4'b0, 4'b0};
        endcase
    end

endmodule
// end::module_source[]

module test();

    reg [3:0] data;
    reg [1:0] sel;
    wire [3:0] outs[3:0];

    demultiplexer uut(
        .data(data),
        .sel(sel),
        .A(outs[0]),
        .B(outs[1]),
        .C(outs[2]),
        .D(outs[3])
    );

    initial begin
        $dumpvars(0,test);

        data = 4'b0001;
        sel = 0;
        #10;
        data = 4'b0010;
        sel = 1;
        #10;
        data = 4'b0100;
        sel = 2;
        #10;
        data = 4'b1000;
        sel = 3;
        #10;
    end

endmodule