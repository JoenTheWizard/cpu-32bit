#include <stdio.h>
#include <unistd.h>

// *** Will start to work on the assembler once the CPU is refined. ***

int main(int argc, char *argv[]) {

    int opt;
    int verbose           = 0;
    int output_file       = 0;
    char *output_filename = NULL;

    //No argument passed
    if (argc == 1) {
        fprintf(stderr, "Usage: %s [-v] [-o filename]\n", argv[0]);
        return 1;
    } 

    //Options available:
    // -o [filename]: output assembled binary file
    // -v: enable verbose mode (will be used for debugging)
    while ((opt = getopt(argc, argv, "vo:")) != -1) {
        switch (opt) {
            case 'v':
                verbose = 1;
                break;
            case 'o':
                output_file = 1;
                output_filename = optarg;
                break;
            default:
                fprintf(stderr, "Usage: %s [-v] [-o filename]\n", argv[0]);
                return 1;
        }
    }

    //Check if there are any remaining non-option arguments
    if (optind < argc) {
        fprintf(stderr, "Error: Non-option arguments '%s' are not allowed\n", argv[optind]);
        fprintf(stderr, "Usage: %s [-v] [-o filename]\n", argv[0]);
        return 1;
    }

    //Verbose mode
    if (verbose) {
        printf("[+] Verbose mode enabled\n");
    }

    //Output file
    if (output_file) {
        printf("[+] Output file: %s\n", output_filename);
    }

    //Do the Assembling process here...
    fprintf(stdout, "[+] Assembling\n");

    return 0;
}