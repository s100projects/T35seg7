/********************************************************************
*   FILE:  T35seg7_top.v                                            *
*                                                                   *
*   This is a simple project that displays 0 to F on the T35        *
*   seven segment display continuously.                             *
*   TFOX, N4TLF September 9, 2021   You are free to use it          *
*       however you like.  No warranty expressed or implied         *
********************************************************************/

module  T35seg7_top (
    clockIn,                // 50MHz input from onboard oscillator
//  n_reset,                // Uncomment to have an external reset    
    dp,                     // 7 segment display decimal point
    segment7);              // 7 segment display, main LEDs

    input   clockIn;
//  input   n_reset;        // Uncomment to have an external reset
    output  reg dp;
    output  reg [6:0] segment7;

reg [25:0]  counter;        // 26-bit counter for one second count
reg [3:0]   digit;          // 4-bit counter for 7 seg 0-F display

wire n_reset;               // Comment this line out to have an external reset
assign n_reset = 1'b1;      // Comment this line out to have an external reset

always @(posedge clockIn)
    begin
        if(n_reset == 0) begin              // if reset set low...
            digit <= 4'b0000;               // reset digit to 0
            counter <= 25'b0;               // reset counter to 0
            end                             // end of resetting everything
        else
        begin
            counter <= counter + 1;         // increment counter
            if(counter == 25000000) begin   // decimal point 1/2 second on/off
                dp = !dp;                   // turn off decimal point
                end                         // end of decimap point test
            if(counter >= 50000000) begin   // counter is at 1 second
                digit <= digit + 1;         // increment to next digit
                dp = !dp;                   // turn decimal point back on
                counter <= 25'b0;           // finally, reset counter
            end                             // end of one second test
        end
        case(digit)
            4'h0: segment7 = 7'b1000000;    // display 0
            4'h1: segment7 = 7'b1111001;    // display 1
            4'h2: segment7 = 7'b0100100;    // display 2
            4'h3: segment7 = 7'b0110000;    // display 3
            4'h4: segment7 = 7'b0011001;    // display 4
            4'h5: segment7 = 7'b0010010;    // display 5
            4'h6: segment7 = 7'b0000010;    // display 6
            4'h7: segment7 = 7'b1111000;    // display 7
            4'h8: segment7 = 7'b0000000;    // display 8
            4'h9: segment7 = 7'b0010000;    // display 9
            4'ha: segment7 = 7'b0001000;    // display A
            4'hb: segment7 = 7'b0000011;    // display B
            4'hc: segment7 = 7'b1000110;    // display C
            4'hd: segment7 = 7'b0100001;    // display D
            4'he: segment7 = 7'b0000110;    // display E
            default: segment7 = 7'b0001110; // otherwise display F
        endcase
    end
endmodule
