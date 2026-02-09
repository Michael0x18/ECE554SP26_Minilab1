module minilab1b();

logic clk, rst_n;

logic done, display_en;
logic [2:0] display_C0X;

logic [6:0] display_out [0:5];

logic [23:0] expected [0:7];

minilab1b iDUT(
  // inputs
  .CLOCK_50(clk),
  .KEY({3'b0, rst_n}),
  .SW({5'b0, display_C0X, display_en}),

  // outputs
  .HEX0(display_out[0]),
  .HEX1(display_out[1]),
  .HEX2(display_out[2]),
  .HEX3(display_out[3]),
  .HEX4(display_out[4]),
  .HEX5(display_out[5]),
  .LEDR({9'b0, done})
);

initial begin
  clk = 1'b0;
  rst_n = 1'b1;
  display_en = 1'b0;
  display_C0X = 3'b0;

  // TODO: Populate expected!
  expected[0] = 24'h;
  expected[1] = 24'h;
  expected[2] = 24'h;
  expected[3] = 24'h;
  expected[4] = 24'h;
  expected[5] = 24'h;
  expected[6] = 24'h;
  expected[7] = 24'h;

  @(posedge clk)
  rst_n = 1'b1;
  display_en = 1'b1;

  @(posedge done) 
  for(display_C0X = 0; display_C0X < 8; display_C0X++) begin
    // May be incorrect wait period for macout switch
    @(posedge clk)

    if (iDUT.macout !== expected[display_C0X]) begin
      $display("Display error! Expected: $d . Actual $d", iDUT.macout, expected[display_C0X]);
      $stop;
    end
  end

  $display("YAHOO!!! ALL TESTS PASSED.");
  $stop;

end



always #5 clk = ~clk;


endmodule