`timescale 1us / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 06:47:07 PM
// Design Name: 
// Module Name: alarm_clock
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


module alarm_clock(
    input clk,
    input reset,
    input [7:0] hour_in,
    input [7:0] minute_in,
    input load_time,
    input load_alarm,
    input stop_alarm,
    input alarm_on,
    output reg alarm,
    output reg [7:0] hour_out,
    output reg [7:0] minute_out,
    output reg [7:0] second_out
    );
    
    //Internal signal
    reg clk_1s;
    reg [31:0] count;
    
    reg [7:0] hour;
    reg [7:0] minute;
    reg [7:0] second;
    
    reg [7:0] alarm_hour;
    reg [7:0] alarm_minute;
    
    //Clock operation
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            hour <= 8'b0000_0000;
            minute <= 8'b0000_0000;
            second <= 8'b0000_0000;
            alarm_hour <= 8'b0000_0000;
            alarm_minute <= 8'b0000_0000;
        end
        else begin
            if(load_alarm) begin
                alarm_hour <= hour_in;
                alarm_minute <= minute_in;
            end
            if(load_time) begin
                hour <= hour_in;
                minute <= minute_in;
            end
        end
    end
    
    //Clock working
    always @(posedge clk_1s) begin
        if(load_time == 0) begin
            second <= second + 1;
            if(second >= 59) begin
                second <= 8'b0000_0000;
                minute <= minute + 1;
                if(minute >= 59) begin
                    minute <= 8'b0000_0000;
                    hour <= hour + 1;
                    if(hour >= 23)
                        hour <= 8'b0000_00000;
                end
            end
        end
    end
    
    //Clock Freq Divider
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            clk_1s <= 0;
            count <= 32'd0;
        end
        else begin
            count <= count + 1;
            if(count == 12_500) begin
                clk_1s <= ~clk_1s;
                count <= 32'd0;
            end
        end
    end
    
    //Clock output
    always @(*) begin
        hour_out <= hour;
        minute_out <= minute;
        second_out <= second;
    end
    
    //Alarm Function
    always @(posedge clk or posedge reset) begin
        if(reset)
            alarm <= 1'b0;
        else begin
            if({hour, minute} == {alarm_hour, alarm_minute}) begin
                if(alarm_on)
                    alarm <= 1'b1;
                if(stop_alarm)
                    alarm <= 1'b0;
            end
            else
                alarm <= 1'b0;
        end
    end
endmodule
