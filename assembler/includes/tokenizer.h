#ifndef TOKENIZER_H
#define TOKENIZER_H

#include <stdio.h>

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
typedef struct {
    TokenType type;
    char *value;
    size_t length;
} Token;

void read_file(const char *filename);

#endif // TOKENIZER_H