module ahb_biu(
  // AHB Interface Signals
  input             hclk,
  input             hrstn,
  input  [32  -1:0] haddr,
  output [32  -1:0] hrdata,
  input  [32  -1:0] hwdata,
  input  [2     :0] hsize,
  input             hwrite,
  input             hsel,
  input  [1     :0] htrans,
  output            hready_o,
  input             hready_i,
  // Internal Interface Signals
  output [32  -1:0] addr_o,
  output [32  -1:0] wr_dat_o,
  input  [32  -1:0] rd_dat_i,
  output [4   -1:0] wr_ena_o,
  output [4   -1:0] rd_ena_o
);

localparam IDLE = 2'b00;
localparam OP   = 2'b01;
localparam WAIT = 2'b10;

reg [2  -1:0] cur_state, nxt_state;
reg [32 -1:0] op_addr;
reg [4  -1:0] wr_ena_r, rd_ena_r;

wire ahb_valid;
assign ahb_valid = hready_i && hsel;

always@(posedge hclk or negedge hrstn) begin
  if(hrstn == 'b0)
    cur_state <= IDLE;
  else
    cur_state <= nxt_state;
end

// AHB Address Fetch
always@(posedge hclk or negedge hrstn) begin
  if(hrstn == 'b0) begin
    op_addr <= 'h0;
  end 
  else if(ahb_valid)
    op_addr <= haddr;
  else if(cur_state != WAIT)
    op_addr <= 'h0;
end

// AHB Enable Control Signals
always@(posedge hclk or negedge hrstn) begin
  if(hrstn == 'b0) begin
    rd_ena_r <= 4'b0000;
    wr_ena_r <= 4'b0000;
  end 
  else begin

  end
end

endmodule
