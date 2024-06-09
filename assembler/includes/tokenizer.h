#ifndef TOKENIZER_H
#define TOKENIZER_H

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

// *** Will need to reorganize some of this ***

//All available types of Tokens
typedef enum {
    TOKEN_LABEL,
    TOKEN_INSTRUCTION,
    TOKEN_REGISTER,
    TOKEN_IMMEDIATE,
    TOKEN_COMMA,
    TOKEN_NEWLINE,
    TOKEN_EOF,
    TOKEN_INVALID
} TokenType;

//Tokens will store type, it's value and length
typedef struct Node {
    TokenType    type;
    char        *value;
    size_t       length;
    struct Node *next;
} TokenNode;

typedef struct {
    TokenNode *head_token;
} TokenList;

void Assemble(const char *filename);

#endif // TOKENIZER_H