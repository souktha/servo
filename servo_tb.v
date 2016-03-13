`timescale 1 ns / 100 ps

module servo_tb (
    );
    reg clock;
    reg [1:0] sw;
    wire pw;

    initial begin
     #5 clock = 1'b0;
     forever #5 clock = !clock;
    end
    initial begin
        @(posedge clock)  #10 sw = 2'b01;
        #30000000 sw = 2'b00;
        #30000000 sw = 2'b11;
        #30000000 sw = 2'b01;
        #30000000 sw = 2'b10;
        $display("time %d, pw %b",$time,pw);
        $finish;
        end
    /*initial begin
        $dumpfile("servo_tb.vcd");
    $dumpvars(1,servo);
    end */ 

    servo servo_tb(.clk(clock),.pos(sw),._control(pw));

endmodule
