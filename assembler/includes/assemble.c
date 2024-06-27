#include "assemble.h"

void Assemble(const char *filename, const char *output_filename) {
    char *fasm_content = ReadFile(filename);

    if (fasm_content == NULL) {
        fprintf(stderr, "[-] There was an error when trying to read the file '%s'\n", filename);
        return;
    }

    TokenList *token_list = InitializeTokenList();

    if (!token_list) {
        fprintf(stderr, "[-] Error: Failed to initialize token list\n");
        free(fasm_content);
        return;
    }

    FILE *output_file = fopen(output_filename, "w");
    if (!output_file) {
        fprintf(stderr, "[-] Error: Failed to open output file '%s'\n", output_filename);
        free(fasm_content);
        FreeTokenList(token_list);
        return;
    }

    Tokenize(fasm_content, token_list);

    SetMemoryTokenList(token_list);

    ParseTokenList(token_list, output_file);

    //PrintTokenList(token_list);

    free(fasm_content);
    fclose(output_file);
    FreeTokenList(token_list);
}