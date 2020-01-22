module pingpong(clk, rst_n, flip, hold, out, max, min, dir);
input clk, rst_n, flip, hold;
output reg [3:0] out;
output max, min;
output reg dir;

reg [3:0] next_out;
reg next_dir;

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0)begin
        dir <= 1'b0;
        out <= 4'b0000;
    end
    else begin
        dir <= next_dir;
        out <= next_out;
    end
end


always @(*) begin
    next_out = out;
    next_dir = dir;
    if (hold == 0) begin
        if (dir == 1'b0) begin
            next_out = out + 1'b1;
            if (flip == 1'b0) begin
                next_dir = (out == 4'b1110)? 1'b1: 1'b0;
            end
            else begin
                next_dir = (out != 4'b0000)? !dir: dir;
            end
        end
        else begin
            next_out = out - 1'b1;
            if (flip == 1'b0) begin
                next_dir = (out == 4'b0001)? 1'b0: 1'b1;
            end
            else begin
                next_dir = (out != 4'b1111)? !dir: dir;
            end
        end
    end
    else begin
    end
end
assign max = (out == 4'b1111)? 1'b1: 1'b0;
assign min = (out == 4'b0000)? 1'b1: 1'b0;

endmodule
