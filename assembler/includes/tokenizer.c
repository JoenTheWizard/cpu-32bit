#include "tokenizer.h"

TokenList *InitializeTokenList(void) {
    TokenList *list = (TokenList*)malloc(sizeof(TokenList));

    if (!list)
        return NULL;

    list->head_token = NULL;
    return list;
}

TokenNode *InitializeTokenNode(TokenType type, char *value, size_t length) {
    TokenNode *node = (TokenNode*)malloc(sizeof(TokenNode));

    if (!node)
        return NULL;

    node->type = type;

    node->value = malloc(length + 1);
    if (!node->value) {
        free(node);
        return NULL;
    }
    strncpy(node->value, value, length);
    node->value[length] = '\0';

    node->length = length;

    node->next = NULL;

    return node;
}

void AddTokenList(TokenList *list, TokenType type, char *value, size_t length) {
    TokenNode *cur = NULL;
    
    if (list->head_token == NULL) {
        list->head_token = InitializeTokenNode(type, value, length);
    }
    else {
        cur = list->head_token;

        while (cur->next != NULL)
            cur = cur->next;

        cur->next = InitializeTokenNode(type, value, length);
    }
}

void PrintTokenList(TokenList *list) {
    TokenNode* cur = list->head_token;

    if (list->head_token == NULL) {
        return;
    }

    while (cur != NULL) {
        printf("TokType: %d - %s\n", cur->type, cur->value);
        cur = cur->next;
    } 
}

void FreeTokenList(TokenList *list) {
    TokenNode *cur = list->head_token;
    TokenNode *next = cur;
    
    while (cur != NULL) {
        next = cur->next;

        free(cur->value);
        free(cur);
        
        cur = next;
    }

    free(list);
}

char* ReadFile(const char *filename) {
    FILE *fasm = fopen(filename, "r");

    if (fasm == NULL) {
        fprintf(stderr, "[-] Unable to find file '%s'\n", filename);
        return NULL;
    }

    //Find size of file
    fseek(fasm, 0, SEEK_END);
    long fasm_size = ftell(fasm);
    rewind(fasm);

    //Allocate memory
    char *buffer = malloc((fasm_size + 1) * sizeof(char));
    if (buffer == NULL) {
        fprintf(stderr, "[-] Failed to allocate file buffer memory\n");
        fclose(fasm);
        return NULL;
    }

    //Read file into buffer
    size_t bytes_read = fread(buffer, sizeof(char), fasm_size, fasm);
    if (bytes_read != fasm_size) {
        fprintf(stderr, "[-] Failed to read entire file size\n");
        free(buffer);
        fclose(fasm);
        return NULL;
    }

    buffer[fasm_size] = '\0';

    fclose(fasm);

    return buffer;
}

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

    fprintf(stdout, "%s\n", fasm_content);

    free(fasm_content);

    FreeTokenList(token_list);
}