`timescale 1ns/1ps

module problem(
    input [3:0] ceo,
    input [3:0] you,
    input [3:0] fred,
    input [3:0] jill,
    input [1:0] sel,
    input enable,
    output [3:0] data
);

    assign data = enable ? (
                    (sel == 0 ? ceo :
                     sel == 1 ? you :
                     sel == 2 ? fred :
                     sel == 3 ? jill : 0)
                    ) : 0;

endmodule