#ifndef TOKENIZER_H
#define TOKENIZER_H

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>
#include <string.h>

// *** Will need to reorganize some of this ***

#define MAX_REGISTER 31

//All available types of Tokens
typedef enum {
    TOKEN_LABEL_DECLARE,
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
    uint32_t     memory;
    struct Node *next;
} TokenNode;

typedef struct {
    TokenNode *head_token;
} TokenList;

//Map instruction memory
static struct {
    char   *instruction;
    int32_t memory_value;
} instruction_map[] = {
    {"NOP",  0b000000},
    {"ADD",  0b000001},
    {"SUB",  0b000010},
    {"MUL",  0b000011},
    {"AND",  0b000100},
    {"OR",   0b000101},
    {"JMP",  0b000110},
    {"LUI",  0b000111},
    {"LLI",  0b001000},
    {"CMP",  0b001010},
    {"JEQ",  0b001011},
    {"LOD",  0b001100},
    {"STR",  0b001101},
    {"XOR",  0b001110},
    {"XNOR", 0b001111},
    {"SHL",  0b010000},
    {"SHR",  0b010001},
    {"JNE",  0b010010},
    {"JB",   0b010011},
    {"JBE",  0b010100},
    {"JL",   0b010101},
    {"JLE",  0b010110},
    {"INC",  0b010111},
    {"DEC",  0b011000},
    {"CALL", 0b011001},
    {"RET",  0b011010},
    {"NOT",  0b011011},
    {"MOV",  0b011100},
    {"JMPR", 0b011101},
    {"JEQR", 0b011110},
    {"JNER", 0b011111},
    {"JBR",  0b100000},
    {"JBER", 0b100001},
    {"JLR",  0b100010},
    {"JLER", 0b100011}
};

void Assemble(const char *filename);

#endif // TOKENIZER_H