#include "tokenizer.h"

TokenList *InitializeTokenList(void) {
    TokenList *list = (TokenList*)malloc(sizeof(TokenList));

    if (!list)
        return NULL;

    list->head_token = NULL;
    return list;
}

TokenNode *InitializeTokenNode(TokenType type, const char *value, size_t length) {
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

void AddTokenList(TokenList *list, TokenType type, const char *value, size_t length) {
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
    TokenNode *cur = list->head_token;

    if (list->head_token == NULL) {
        return;
    }

    while (cur != NULL) {
        printf("TokType: %d - %s (l: %ld)\n", cur->type, cur->value, cur->length);
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

char *ReadFile(const char *filename) {
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

int ParseToken(const char *source, TokenList *list, int position) {
    int end_pos = position, start_pos = position;
    TokenType token_type;

    //Skip whitespace characters (except for new line for the assembler)
    while (isspace(source[start_pos]) && source[start_pos] != '\n')
        start_pos++;

    end_pos = start_pos;

    //Determine token type
    if (isalpha(source[start_pos])) {
        //Label or instruction
        end_pos++;
        while (isalnum(source[end_pos]) || source[end_pos] == '_')
            end_pos++;
        token_type = TOKEN_INSTRUCTION; //Assume instruction by default

        //Check if it's a label
        if (source[end_pos] == ':') {
            token_type = TOKEN_LABEL;
            end_pos++;
        }
    } 
    else if (isdigit(source[start_pos])) {
        //Immediate value
        token_type = TOKEN_IMMEDIATE;
        end_pos++;
        while (isdigit(source[end_pos]))
            end_pos++;
    } 
    else {
        //Special characters
        switch (source[start_pos]) {
            case ',':
                token_type = TOKEN_COMMA;
                end_pos++;
                break;
            case '\n':
                token_type = TOKEN_NEWLINE;
                end_pos++;
                break;
            case '\0':
                token_type = TOKEN_EOF;
                end_pos++;
                break;
            default:
                token_type = TOKEN_INVALID;
                end_pos++;
                break;
        }
    }

    size_t token_length = end_pos - start_pos;
    AddTokenList(list, token_type, &source[start_pos], token_length);

    return end_pos;
}

int Tokenize(const char *source, TokenList *list) {
    int position      = 0;
    int source_length = strlen(source);

    while (position < source_length) {
        position = ParseToken(source, list, position);
    }

    return 0;
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

    Tokenize(fasm_content, token_list);

    PrintTokenList(token_list);

    free(fasm_content);

    FreeTokenList(token_list);
}