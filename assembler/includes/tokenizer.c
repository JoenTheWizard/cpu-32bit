#include "tokenizer.h"

void read_file(const char *filename) {
    FILE *fasm = fopen(filename, "r");

    if (fasm == NULL) {
        fprintf(stderr, "[-] Unable to find file '%s'\n", filename);
        return;
    }

    char ch;

    while ((ch = fgetc(fasm)) != EOF) {
        fprintf(stdout, "%c", ch);
    }

    fclose(fasm);
}