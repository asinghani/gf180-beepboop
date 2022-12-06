module beepboop (
        io_in,
        io_out
);
        input [7:0] io_in;
        output wire [7:0] io_out;
        wire clock = io_in[0];
        wire reset = io_in[1];
        wire btn = io_in[2];
        reg red;
        reg yellow;
        reg green;
        reg walk;
        reg no_walk;
        reg the_beepbooper;
        assign io_out = {2'b00, the_beepbooper, no_walk, walk, green, yellow, red};
        reg [15:0] counter;
        always @(posedge clock)
                if (reset)
                        counter <= 0;
                else begin
                        if (counter != 0)
                                counter <= counter + 1;
                        if (counter >= 2200)
                                counter <= 0;
                        if ((counter == 0) && btn)
                                counter <= 1;
                end
        always @(*) begin
                green = (counter == 0) || (counter >= 2200);
                yellow = (counter > 0) && (counter < 200);
                red = (counter >= 200) && (counter < 2200);
                walk = (counter > 300) && (counter < 1500);
                the_beepbooper = walk;
                no_walk = (((((counter >= 1500) && (counter < 1600)) || ((counter >= 1700) && (counter < 1800))) || ((counter >= 1900) && (counter < 2000))) || (counter >= 2100)) || (counter <= 300);
        end
endmodule
