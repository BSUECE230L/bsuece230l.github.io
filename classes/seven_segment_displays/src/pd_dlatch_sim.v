`timescale 1ps/1ps

module pd_dlatch(
    input store,
    input [7:0] data,
    output reg [7:0] memory
);

    assign #1 not1 = ~store;
    assign #1 not2 = ~not1;
    assign #1 not3 = ~not2;

    assign pd_out = store & not3;

    always @(pd_out, data)
        if (pd_out)
            memory <= data;

endmodule

module test();

    reg store;
    reg [7:0] data;
    wire [7:0] memory;

    pd_dlatch uut(
        .store(store),
        .data(data),
        .memory(memory)
    );

    initial begin
        $dumpvars(0,test);
        store = 0;
        #5;
        store = 1;
        data = 0;
        #5;
        store = 0;
        #15;
        store = 1;
        data = 'hFF;
        #15;
        data = 'h00;
        #15;
        $finish;
    end

endmodule