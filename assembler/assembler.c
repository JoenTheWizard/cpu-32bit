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

    //Check if an input file is provided
    if (optind >= argc) {
        fprintf(stderr, "[-] Expected input file after options\n");
        return 1;
    }

    //Specified output file
    if (output_file) {
        fprintf(stdout, "[+] Output filename: %s\n", output_filename);
    }

    //Verbose mode
    if (verbose) {
        fprintf(stdout, "[+] Verbose mode enabled\n");
    }

    //Do the Assembling process here...
    fprintf(stdout, "[+] Assembling file '%s'\n", argv[optind]);

    return 0;
}