sequence_detector_tb.v
`timescale 1ns/1ps

module sequence_detector_tb;

    reg clk;
    reg reset;
    reg data_in;
    wire detected;

    // Instantiate DUT
    sequence_detector uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .detected(detected)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task to apply input
    task send_bit(input reg bit_value);
    begin
        data_in = bit_value;
        #10;

        $display("Time = %0t | Input = %b | Detected = %b",
                 $time, data_in, detected);
    end
    endtask

    initial begin

        clk = 0;
        reset = 1;
        data_in = 0;

        #10;

        reset = 0;

        $display("======================================");
        $display("     SEQUENCE DETECTOR TESTBENCH");
        $display("     Detecting Sequence: 1011");
        $display("======================================");

        // Send sequence 1011
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);

        // Additional bits
        send_bit(0);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);

        #10;

        $display("======================================");
        $display("Simulation Completed");
        $display("======================================");

        $finish;
    end

endmodule