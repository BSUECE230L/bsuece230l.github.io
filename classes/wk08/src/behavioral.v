`timescale 1ns/1ps

module behavioral(
    input [3:0] ceo,
    input [3:0] you,
    input [3:0] fred,
    input [3:0] jill,
    input [1:0] sel,
    input enable,
    output reg [3:0] data // <1>
);
    always @(*) begin // <2>
        if (enable) begin // <3>
            case (sel) // <4>
                2'b00: data = ceo; // <5>
                2'b01: data = you;
                2'b10: data = fred;
                2'b11: data = jill;
            endcase
        end else begin
            data = 0;
        end
    end
endmodule

module test();

    reg [3:0] ceo;
    reg [3:0] you;
    reg [3:0] fred;
    reg [3:0] jill;
    reg [1:0] sel;
    reg enable;
    wire [3:0] data;

    behavioral uut(
        .ceo(ceo),
        .you(you),
        .fred(fred),
        .jill(jill),
        .sel(sel),
        .enable(enable),
        .data(data)
    );

    initial begin
        $dumpvars(0,test);
        ceo = 'b0101;
        you = 'b1001;
        fred = 'b0110;
        jill = 'b1010;
        enable = 0;
        sel = 0;
        #10;
        enable = 1;
        #10;
        sel = 'b01;
        #10;
        sel = 'b10;
        #10;
        sel = 'b11;
        #10;
        enable = 0;
        #10;
    end

endmodule