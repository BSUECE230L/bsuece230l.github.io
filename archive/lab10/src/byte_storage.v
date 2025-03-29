`timescale 1ps/1ps

// tag::module_source[]
module byte_memory(
    input [7:0] data,
    input store,
    output reg [7:0] memory
);

    always @(store, data) begin
        if (store)
            memory <= data;
    end

endmodule
// end::module_source[]

// tag::changed_sensitivity_list[]
module byte_memory_nodata(
    input [7:0] data,
    input store,
    output reg [7:0] memory
);

    always @(store) begin
        if (store)
            memory <= data;
    end

endmodule
// end::changed_sensitivity_list[]

// tag::with_ff[]
module byte_memory_ff(
    input [7:0] data,
    input store,
    output reg [7:0] memory
);

    always @(posedge store)
        memory <= data;

endmodule
// end::with_ff[]

module test();

    reg [7:0] data;
    reg store;
    wire [7:0] memory;
    wire [7:0] memory_nodata;
    wire [7:0] memory_ff;

    byte_memory uut(
        .data(data),
        .store(store),
        .memory(memory)
    );

    byte_memory_nodata uut_nodata(
        .data(data),
        .store(store),
        .memory(memory_nodata)
    );

    byte_memory_ff uut_ff(
        .data(data),
        .store(store),
        .memory(memory_ff)
    );

    initial begin
        $dumpvars(0, test);
        store = 0;
        data = 0;
        #10;
        store = 1;
        data = 'hFF;
        #5;
        data = 'hF0;
        #5;
        data = 'h0F;
        #5;
        data = 'hAB;
        #5;
        data = 'hBA;
        $finish;
    end
endmodule