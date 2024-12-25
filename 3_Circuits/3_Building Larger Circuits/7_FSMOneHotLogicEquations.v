module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //

    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, count=8, hold=9;

    assign B3_next = state[B2];
    assign S_next = (state[S] & (~d)) | (state[S1] & (~d)) | (state[S110] & (~d)) | (state[hold] & ack);
    assign S1_next = state[S] & d;
    assign Count_next = state[B3] | (state[count] & (~done_counting));
    assign Wait_next = (state[count] & (done_counting)) | (state[hold] & (~ack));
    assign done = state[hold];
    assign counting = state[count];
    assign shift_ena = state[B0] | state[B1] | state[B2] | state[B3];

endmodule