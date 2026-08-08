sequence_detector.
module sequence_detector (
    input  wire clk,
    input  wire reset,
    input  wire data_in,
    output reg detected
);

    // State declaration
    reg [2:0] state, next_state;

    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        next_state = S0;
        detected = 1'b0;

        case (state)

            S0: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (data_in)
                    next_state = S3;
                else
                    next_state = S0;
            end

            S3: begin
                if (data_in) begin
                    next_state = S1;
                    detected = 1'b1;
                end
                else begin
                    next_state = S2;
                end
            end

            default: begin
                next_state = S0;
                detected = 1'b0;
            end

        endcase
    end

endmodule