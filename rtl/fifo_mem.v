`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.08.2026 19:34:21
// Design Name: 
// Module Name: fifo_mem
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


module fifo_mem #(parameter DEPTH=8,DATA_WIDTH=8,PTR_WIDTH=3 )(
    input w_clk,w_en,r_clk,r_en,
    input[PTR_WIDTH:0] b_wptr,b_rptr,
    input[DATA_WIDTH-1:0] data_in,
    input full,empty,
    output reg[DATA_WIDTH-1:0] data_out
    );
    reg [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
    always @(posedge w_clk) begin
        if(w_en && !full) begin
            fifo[b_wptr[PTR_WIDTH-1:0]]<=data_in;
        end
    end
    
    assign data_out=fifo[b_rptr[PTR_WIDTH-1:0]];
endmodule
