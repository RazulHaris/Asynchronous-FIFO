`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 21:07:42
// Design Name: 
// Module Name: wptr_handler
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


module wptr_handler #(parameter PTR_WIDTH=3)(
    input w_clk,w_rstn,w_en,
    input [PTR_WIDTH:0] g_rptr_sync,
    output reg [PTR_WIDTH:0] b_wptr, g_wptr,
    output reg full
    );

    reg [PTR_WIDTH:0] b_wptr_next; 
    reg [PTR_WIDTH:0] g_wptr_next;

    reg wrap_around;
    wire wfull;

    assign b_wptr_next = b_wptr +(w_en & !full); //increment wptr if enable and !full
    assign g_wptr_next = (b_wptr_next>>1)^b_wptr_next; //binary to gray conversion


    always @(posedge w_clk or negedge w_rstn) begin
        if(!w_rstn) begin
            b_wptr<=0;
            g_wptr<=0;
        end

        else begin
            b_wptr<=b_wptr_next;
            g_wptr<=g_wptr_next;
        end
    end

    always @(posedge w_clk or negedge w_rstn) begin
        if(!w_rstn) full <= 0;
        else    full<=wfull;
    end
    
     assign wfull = (g_wptr_next =={~g_rptr_sync[PTR_WIDTH:PTR_WIDTH-1],g_rptr_sync[PTR_WIDTH-2:0]});

endmodule
