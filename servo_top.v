`timescale 10 ns / 100 ps

module servo_top (
    input CLK100MHZ,
    input [1:0] SW,
    output [1:0] LED,
    output JA
    );

    assign LED = SW;

    servo servo_main(.clk(CLK100MHZ),.pos(SW), .control(JA));

endmodule
