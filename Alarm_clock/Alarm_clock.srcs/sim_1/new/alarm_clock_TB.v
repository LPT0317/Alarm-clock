`timescale 1us / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2023 08:10:35 AM
// Design Name: 
// Module Name: alarm_clock_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alarm_clock_TB();
    //Inputs
    reg clk;
    reg reset;
    reg [7:0] hour_in;
    reg [7:0] minute_in;
    reg load_time;
    reg load_alarm;
    reg stop_alarm;
    reg alarm_on;
    
    //Output
    wire alarm;
    wire [7:0] hour_out;
    wire [7:0] minute_out;
    wire [7:0] second_out;
    
    // Instantiate the Unit Under Test (UUT)
    alarm_clock uut_ac(
        .clk(clk),
        .reset(reset),
        .hour_in(hour_in),
        .minute_in(minute_in),
        .load_time(load_time),
        .load_alarm(load_alarm),
        .stop_alarm(stop_alarm),
        .alarm_on(alarm_on),
        .alarm(alarm),
        .hour_out(hour_out),
        .minute_out(minute_out),
        .second_out(second_out)
        );
        
    //clock 50kHz
    initial begin
        clk = 0;
        forever #20 clk <= ~clk;
    end
    
    initial begin
        reset = 1;
        load_time = 0;
        load_alarm = 0;
        stop_alarm = 0;
        alarm_on = 0;
        #30
        reset = 0;
        #30
        hour_in = 23;
        minute_in = 57;
        #30
        load_time = 1;
        #30
        load_time = 0;
        #30
        hour_in = 23;
        minute_in = 59;
        #30
        load_alarm = 1;
        #30
        load_alarm = 0;
        alarm_on = 1;
    end
endmodule
