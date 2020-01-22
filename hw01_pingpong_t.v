`timescale 1ns / 100ps

module pingpong_t;
//input signal
reg clk = 0;
reg rst_n = 1;
reg hold = 0;
reg flip = 0;
//output signal
wire [3:0] out;
wire max;
wire min;
wire dir;
integer i = 0;
integer ans = 0;
reg ans_dir = 0;
reg ans_min = 0;
reg ans_max = 0;

parameter cyc = 20;


//instantiate pingpong counter design module
pingpong ppc(.clk(clk),
            .rst_n(rst_n),
            .hold(hold),
            .flip(flip),
            .out(out),
            .max(max),
            .min(min),
            .dir(dir));

always #(cyc / 2) clk = ~clk;

initial begin
     $fsdbDumpfile("hw01_pingpong.fsdb");
     $fsdbDumpvars;
end

initial begin
    @(negedge clk) // trigger reset.
    rst_n = 0;
    #(cyc * 3)
    rst_n = 1;

    $display("========== VERIFYING NORMAL CASE, HOLD = 0, FILP = 0==========");
    //asending
    for (i = 0; i < 16; i = i + 1) begin
        @(negedge clk);
        ans_min = (ans == 0)? 1: 0;
        ans_max = (ans == 15)? 1: 0;
        ans_dir = (ans == 15)? 1: 0;
        if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
            $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
        end
        else begin
            $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
            $display("ERROR DETECTED, ABORTING");
            $finish;
        end
        ans = (ans == 15)? ans - 1: ans + 1;
    end
    //descending
    for (i = 0; i < 15; i = i + 1) begin
        @(negedge clk);
        ans_min = (ans == 0)? 1: 0;
        ans_max = (ans == 15)? 1: 0;
        ans_dir = (ans == 0)? 0: 1;
        if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
            $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
        end
        else begin
            $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
            $display("ERROR DETECTED, ABORTING");
            $finish;
        end
        ans = (ans == 0)? ans: ans - 1;
    end
    $display("========== END OF NORMAL CASE ==========");
    @(negedge clk)
    rst_n = 0;
    #(cyc * 3)
    rst_n = 1;
    ans = 0;
    $display("========== VERIFYING HOLD SIGNAL FUNCTIONALITY ==========");
    for (i = 0; i < 16; i = i + 1) begin
        @(negedge clk)
        ans_min = (ans == 0)? 1: 0;
        ans_max = (ans == 15)? 1: 0;
        ans_dir = (ans == 15)? 1: 0;
        hold = 1;
        if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
            $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
        end
        else begin
            $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
            $display("ERROR DETECTED, ABORTING");
            $finish;
        end
        @(negedge clk)
        hold = 0;
        if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
            $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
        end
        else begin
            $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
            $display("ERROR DETECTED, ABORTING");
            $finish;
        end
        ans = (ans == 15)? ans - 1: ans + 1;
    end
    for (i = 0; i < 15; i = i + 1) begin
        @(negedge clk);
        ans_min = (ans == 0)? 1: 0;
        ans_max = (ans == 15)? 1: 0;
        ans_dir = (ans == 0)? 0: 1;
        hold = 1;
        if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
            $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
        end
        else begin
            $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
            $display("ERROR DETECTED, ABORTING");
            $finish;
        end
        @(negedge clk)
        hold = 0;
        if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
            $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
        end
        else begin
            $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
            $display("ERROR DETECTED, ABORTING");
            $finish;
        end
        ans = (ans == 0)? ans: ans - 1;
    end

    $display("========== END OF HOLD SIGNAL TESTING ==========");


    $display("========== TESTING FLIP SIGNAL FUNCTIONALITY ==========");
    @(negedge clk)
    ans = 1;
    ans_dir = 0;
    ans_max = 0;
    ans_min = 0;
    rst_n = 0;
    #(cyc * 3)
    rst_n = 1;
    flip = 1;
    #(cyc)
    if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
        $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
    end
    else begin
        $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
        $display("ERROR DETECTED, ABORTING");
        $finish;
    end

    for (i = 0; i < 15; i = i + 1) begin
        @(negedge clk)
        rst_n = 0;
        #(cyc * 3)
        rst_n = 1;
        flip = 0;
        ans = i;
        ans_dir = 0;
        if (i != 0) begin
            #(cyc * i);
        end
        @(negedge clk)
        flip = 1;
        ans_dir = (ans != 0 && ans != 15)? !ans_dir: ans_dir;
        ans = ans + 1;
        @(negedge clk)
        ans_min = (ans == 0)? 1: 0;
        ans_max = (ans == 15)? 1: 0;
        if (out == ans && min == ans_min && max == ans_max && dir == ans_dir) begin
            $display("CORRECT! out = %d, min = %d, max = %d, dir = %d", out, min, max, dir);
        end
        else begin
            $display("WRONG! out = %d, ans_out = %2d, min = %d, ans_min = %d, max = %d, ans_max = %d, dir = %d, ans_dir = %d", out, ans, min, ans_min, max, ans_max, dir, ans_dir);
            $display("ERROR DETECTED, ABORTING");
            $finish;
        end
    end




    //
    // #(cyc * 6) hold = 1;
    // #(cyc * 2) hold = 0;
    // #(cyc * 10) flip = 1;
    // #(cyc * 5) flip = 0;
    // #(cyc * 2) flip = 1;
    // #(cyc) flip = 0;
    // #(cyc * 13) flip = 1;
    // #(cyc) flip = 0;
    // #(cyc * 2);
    $finish;
end

endmodule
