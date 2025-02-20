module test();

    reg [1:0] sw;
    wire [1:0] led;


    top uut(
        .sw(sw),
        .led(led)
    );

    initial begin
        $dumpvars(0,test);
        sw = 0;
        #10;
        sw = 2'b10;
        #10;
        sw = 2'b01;
        #10;

    end


endmodule