`timescale 10 ns / 100 ps

module servo (
    input clk,  //base on 100MHZ clock
    input [1:0] pos, //left(10), right(01), neutral(00,11)
    output control
    );
    /* SG90 9g micro servo, Tower Pro (sg90servo.pdf)
     1.5 ms pulse for middle, 2 ms for right, 1 ms for left duty cycle
    ----
    |   |------------------------|
    <---------------------------->
             20ms (50HZ)
    */
    
    localparam MS_20 = 24'h1e8480; //20ms from 100MHZ clock
    localparam MIDDLE = 24'h24f90; // 1.5 ms  middle
    localparam ALLRIGHT = 24'h30d40; // 2ms all the way right
    localparam ALLLEFT = 24'h186a0; //1 ms all the way left

    reg [23:0] count;
    reg pulse;

    initial count = 0; //for simulation

    assign control = pulse; //output

    always@(posedge clk) 
            count <= (count == MS_20) ? 0 : count + 1'b1; /* 20 ms period */

    always@(*) 	
        case(pos)
            2'b01: pulse = (count <= ALLRIGHT); //right all the way
            2'b00: pulse = (count <= ALLLEFT); //left all the way
            default: pulse = (count <= MIDDLE);  //center 
        endcase

endmodule
