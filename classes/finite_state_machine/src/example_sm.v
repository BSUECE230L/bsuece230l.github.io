// tag::dff[]
module dff(
    input Default,
    input D,
    input clk,
    output reg Q
);

    initial begin
        Q <= Default;
    end

    always @(posedge clk)
        Q <= D;

endmodule
// end::dff[]

// tag::one_hot[]
module one_hot(
    input w,
    input clk,
    output z
);
    wire Anext, Bnext, Cnext;
    wire Astate, Bstate, Cstate;

    dff Adff(
        .Default(1'b1),
        .D(Anext),
        .clk(clk),
        .Q(Astate)
    );

    dff Bdff(
        .Default(1'b0),
        .D(Bnext),
        .clk(clk),
        .Q(Bstate)
    );

    dff Cdff(
        .Default(1'b0),
        .D(Cnext),
        .clk(clk),
        .Q(Cstate)
    );

    assign z = Cstate;

    assign Anext = ~w;
    assign Bnext = w & Astate;
    assign Cnext = (w & Bstate) | (w & Cstate);
endmodule
// end::one_hot[]

// tag::binary[]
module binary(
    input w,
    input clk,
    output z
);

    wire [1:0] State;
    wire [1:0] Next;

    dff zero(
        .D(Next[0]),
        .clk(clk),
        .Q(State[0])
    );

    dff one(
        .D(Next[1]),
        .clk(clk),
        .Q(State[1])
    );

    assign z = State[1] & ~State[0];
    assign Next[0] = w & ~State[1] & ~State[0];
    assign Next[1] = w & (State[1] | State[0]);

endmodule
// end::binary[]

// tag::test[]
module test();

    reg w;
    reg clk;
    wire z_onehot;
    wire z_binary;

    reg [1:0] oh_actual;
    reg [1:0] bn_actual;

    one_hot oh(
        .w(w),
        .clk(clk),
        .z(z_onehot)
    );

    binary bn(
        .w(w),
        .clk(clk),
        .z(z_binary)
    );

    task automatic toggle_clock;
        begin
            #1 clk = 1;
            #1 clk = 0;
        end
    endtask

    task automatic check_state_oh(input [1:0] expected_state);
        begin
            if (1 << expected_state != {oh.Cstate, oh.Bstate, oh.Astate}) begin
                $display("FAILED OneHot Check. Expected state %b, found %b", 1 << expected_state, {oh.Cstate, oh.Bstate, oh.Astate});
                $finish;
            end
        end
    endtask

    task automatic check_state_bn(input [1:0] expected_state);
        begin
            if (expected_state != bn.State) begin
                $display("FAILED Binary Check. Expected state %b, found %b", expected_state, bn.State);
                $finish;
            end
        end
    endtask

    task automatic check_state(input [1:0] expected_state);
        begin
            check_state_oh(expected_state);
            check_state_bn(expected_state);
        end
    endtask

    initial begin
        $dumpvars(0,test);
        clk = 0;
        w = 0;
        toggle_clock;
        check_state(2'b00);
        w = 1;
        toggle_clock;
        check_state(2'b01);
        toggle_clock;
        check_state(2'b10);
        toggle_clock;
        check_state(2'b10);
        w = 0;
        toggle_clock;
        check_state(2'b00);
    end

endmodule
// end::test[]