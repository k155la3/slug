module slug(
  input logic clk,
  input logic rst,
  input logic[31:0] port_in,
  output logic[31:0] port_out);

  logic sync_rst;

  initial begin
    sync_rst = 0;
  end

  always @(posedge clk)
    sync_rst <= ~rst;

  logic[15:0] prog_addr;
  logic[7:0] prog, control0, control1, control2;

  /* verilator lint_off UNUSED */
  logic oec, oeb, ldbc, oein, ldout, reram, weram, ldalu, oealu, ldfl, lda, oeop, alum, crin, ldpc, incpc, unused, crout, zero;

  /* verilator lint_off UNOPTFLAT */
  logic[3:0] alus, aluf, alua, alub, flags; 
  logic[2:0] sel;
  logic[7:0] dsel;

  tri[15:0] addr;
  tri[3:0] data;

  counter16 ip(.clk(clk), .rst(sync_rst), .ld(ldpc), .inc(incpc), .x(addr), .y(prog_addr));

  rom #(8,16,"prog.data") prog_rom(.a(prog_addr), .y(prog));
  rom #(8,11,"ucode0.data") ucode0_rom(.a({1'b0, ~flags[1:0], prog}), .y(control0));
  rom #(8,11,"ucode1.data") ucode1_rom(.a({1'b0, ~flags[1:0], prog}), .y(control1));
  rom #(8,11,"ucode2.data") ucode2_rom(.a({1'b0, ~flags[1:0], prog}), .y(control2));

  assign oec = ~control2[7];
  assign oeb = ~control2[6];
  assign ldbc = ~control2[5];
  assign oein = ~control2[4];
  assign ldout = ~control2[3];
  assign sel = control2[2:0];
  assign unused = control1[7];
  assign reram = ~control1[6];
  assign weram = ~control1[5];
  assign ldalu = ~control1[4];
  assign oealu = ~control1[3];
  assign ldfl = ~control1[2];
  assign lda = ~control1[1];
  assign oeop = ~control1[0];
  assign alus = control0[7:4];
  assign alum = control0[3];
  assign crin = ~control0[2];
  assign ldpc = ~control0[1];
  assign incpc = control0[0];
  assign data = oeop ? prog[3:0] : (oealu ? aluf : 4'bz);
  assign alub = ldalu ? data : alua;
  assign zero = ~((aluf[0] | aluf[1]) | (aluf[2] | aluf[3]));

  decoder3 sel_decoder(.x(sel), .y(dsel));

  register4 b0(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[0]), .oe(oeb), .x(data), .y(addr[3:0]));
  register4 b1(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[1]), .oe(oeb), .x(data), .y(addr[7:4]));
  register4 b2(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[2]), .oe(oeb), .x(data), .y(addr[11:8]));
  register4 b3(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[3]), .oe(oeb), .x(data), .y(addr[15:12]));

  register4 c0(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[4]), .oe(oec), .x(data), .y(addr[3:0]));
  register4 c1(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[5]), .oe(oec), .x(data), .y(addr[7:4]));
  register4 c2(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[6]), .oe(oec), .x(data), .y(addr[11:8]));
  register4 c3(.clk(clk), .rst(sync_rst), .ld(ldbc & dsel[7]), .oe(oec), .x(data), .y(addr[15:12]));

  alu alu(.crin(crin), .s(alus), .m(alum), .a(alua), .b(alub), .f(aluf), .crout(crout));

  register4 a(.clk(clk), .rst(sync_rst), .ld(lda), .oe('b1), .x(aluf), .y(alua));
  register4 f(.clk(clk), .rst(sync_rst), .ld(ldfl), .oe('b1), .x({2'b0, zero, crout}), .y(flags));

  register4 in0(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[0]), .x(port_in[3:0]), .y(data));
  register4 in1(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[1]), .x(port_in[7:4]), .y(data));
  register4 in2(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[2]), .x(port_in[11:8]), .y(data));
  register4 in3(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[3]), .x(port_in[15:12]), .y(data));
  register4 in4(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[4]), .x(port_in[19:16]), .y(data));
  register4 in5(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[5]), .x(port_in[23:20]), .y(data));
  register4 in6(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[6]), .x(port_in[27:24]), .y(data));
  register4 in7(.clk(clk), .rst(sync_rst), .ld('b1), .oe(oein & dsel[7]), .x(port_in[31:28]), .y(data));

  register4 out0(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[0]), .oe('b1), .x(data), .y(port_out[3:0]));
  register4 out1(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[1]), .oe('b1), .x(data), .y(port_out[7:4]));
  register4 out2(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[2]), .oe('b1), .x(data), .y(port_out[11:8]));
  register4 out3(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[3]), .oe('b1), .x(data), .y(port_out[15:12]));
  register4 out4(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[4]), .oe('b1), .x(data), .y(port_out[19:16]));
  register4 out5(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[5]), .oe('b1), .x(data), .y(port_out[23:20]));
  register4 out6(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[6]), .oe('b1), .x(data), .y(port_out[27:24]));
  register4 out7(.clk(clk), .rst(sync_rst), .ld(ldout & dsel[7]), .oe('b1), .x(data), .y(port_out[31:28]));

  ram #(4,16) data_ram(.clk(clk), .we(weram), .re(reram), .x(data), .y(data), .a(addr));

  //always @(posedge clk)
  //$display("prog_a: %H %H %H", prog_addr, port_in, port_out);
   
endmodule