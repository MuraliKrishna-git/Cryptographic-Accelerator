module tb_aes_encrypt;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg start;
    reg [127:0] plaintext;
    reg [127:0] key;
    wire [127:0] ciphertext;
    wire done;

    // Instantiate the design module
    aes_encrypt uut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext),
        .done(done)
    );

    // Clock generation
    always #10 clk = ~clk; // 100 MHz clock

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        start = 0;
        plaintext = 128'h00112233445566778899aabbccddeeff;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        
        // Apply reset
        #100;
        rst_n = 1;

        // Start the encryption process
        #100;
        start = 1;
        #100;
        start = 0;

        // Wait for the encryption to complete
        wait(done);

        // Display the ciphertext
        $display("Ciphertext: %h", ciphertext);

        // End the simulation
        #20;
        $finish;
    end

endmodule
