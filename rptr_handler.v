`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 20:06:50
// Design Name: 
// Module Name: rptr_handler
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


module rptr_handler #(parameter PTR_WIDTH=3)(
    input r_clk,r_rstn,r_en,
    input [PTR_WIDTH:0] g_wptr_sync,
    output reg [PTR_WIDTH:0] b_rptr, g_rptr,
    output reg empty
    );

    reg [PTR_WIDTH:0] b_rptr_next; 
    reg [PTR_WIDTH:0] g_rptr_next;

    assign b_rptr_next = b_rptr +(r_en & !empty); //increment rptr if enable and !empty
    assign g_rptr_next = (b_rptr_next>>1)^b_rptr_next; //binary to gray conversion
    assign rempty = (g_wptr_sync==g_rptr_next);

    always @(posedge r_clk or negedge r_rstn) begin
        if(!r_rstn) begin
            b_rptr<=0;
            g_rptr<=0;
        end

        else begin
            b_rptr<=b_rptr_next;
            g_rptr<=g_rptr_next;
        end
    end

    always @(posedge r_clk or negedge r_rstn) begin
        if(!r_rstn) empty <=1;
        else    empty<=rempty;
    end
endmodule
