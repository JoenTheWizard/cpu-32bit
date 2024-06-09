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

void Assemble(const char *filename) {
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