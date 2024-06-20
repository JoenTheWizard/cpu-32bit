#include "assemble.h"

void Assemble(const char *filename) {
    char *fasm_content = ReadFile(filename);

    if (fasm_content == NULL) {
        fprintf(stderr, "[-] There was an error when trying to read the file '%s'\n", filename);
        return;
    }

    TokenList *token_list = InitializeTokenList();

    if (!token_list) {
        fprintf(stderr, "[-] Failed to initialize token list\n");
        free(fasm_content);
        return;
    }

    Tokenize(fasm_content, token_list);

    SetMemoryTokenList(token_list);

    ParseTokenList(token_list);

    PrintTokenList(token_list);

    free(fasm_content);

    FreeTokenList(token_list);
}