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
    TOKEN_STRING,
    TOKEN_LABEL_DECLARE,
    TOKEN_LABEL_INITIALIZE,
    TOKEN_INSTRUCTION,
    TOKEN_REGISTER,
    TOKEN_IMMEDIATE,
    TOKEN_COMMA,
    TOKEN_S_OPEN_BRACKET,
    TOKEN_S_CLOSE_BRACKET,
    TOKEN_NEWLINE,
    TOKEN_EOF,
    TOKEN_INVALID
} TokenType;

//All available types of Instructions
typedef enum {
    INSTR_NON_INSTR,
    INSTR_R_TYPE,  //Register mode:          op r_src, r_targ, r_dest
    INSTR_I_TYPE,  //Immediate mode:         op r_src, imm
    INSTR_J_TYPE,  //Jump mode:              op imm
    INSTR_S_TYPE,  //Singular mode:          op
    INSTR_IJ_TYPE, //Jump-Indirect mode:     op [r_src]
    INSTR_RT_TYPE, //Register-Target mode:   op r_targ
    INSTR_RR_TYPE, //Register-Register mode: op r_src, r_targ
    INSTR_RI_TYPE  //Register-Indirect mode: op r_src, [r_targ]
} InstructionType;

//Tokens will store type, it's value, length, memory value and instruction type if applicable
typedef struct Node {
    TokenType       type;
    char           *value;
    size_t          length;
    uint32_t        memory;
    InstructionType instruction_type;
    struct Node    *next;
} TokenNode;

typedef struct {
    TokenNode *head_token;
} TokenList;

//Map instruction memory
static struct {
    char           *instruction;
    int32_t         memory_value;
    InstructionType instruction_type; 
} instruction_map[] = {
    {"NOP",  0b000000, INSTR_S_TYPE},
    {"ADD",  0b000001, INSTR_R_TYPE},
    {"SUB",  0b000010, INSTR_R_TYPE},
    {"MUL",  0b000011, INSTR_R_TYPE},
    {"AND",  0b000100, INSTR_R_TYPE},
    {"OR",   0b000101, INSTR_R_TYPE},
    {"JMP",  0b000110, INSTR_J_TYPE},
    {"LUI",  0b000111, INSTR_I_TYPE},
    {"LLI",  0b001000, INSTR_I_TYPE},
    {"CMP",  0b001010, INSTR_RR_TYPE},
    {"JEQ",  0b001011, INSTR_J_TYPE},
    {"LOD",  0b001100, INSTR_RI_TYPE},
    {"STR",  0b001101, INSTR_RI_TYPE},
    {"XOR",  0b001110, INSTR_R_TYPE},
    {"XNOR", 0b001111, INSTR_R_TYPE},
    {"SHL",  0b010000, INSTR_R_TYPE},
    {"SHR",  0b010001, INSTR_R_TYPE},
    {"JNE",  0b010010, INSTR_J_TYPE},
    {"JB",   0b010011, INSTR_J_TYPE},
    {"JBE",  0b010100, INSTR_J_TYPE},
    {"JL",   0b010101, INSTR_J_TYPE},
    {"JLE",  0b010110, INSTR_J_TYPE},
    {"INC",  0b010111, INSTR_RT_TYPE},
    {"DEC",  0b011000, INSTR_RT_TYPE},
    {"CALL", 0b011001, INSTR_J_TYPE},
    {"RET",  0b011010, INSTR_S_TYPE},
    {"NOT",  0b011011, INSTR_RR_TYPE},
    {"MOV",  0b011100, INSTR_RR_TYPE},
    {"JMPR", 0b011101, INSTR_IJ_TYPE},
    {"JEQR", 0b011110, INSTR_IJ_TYPE},
    {"JNER", 0b011111, INSTR_IJ_TYPE},
    {"JBR",  0b100000, INSTR_IJ_TYPE},
    {"JBER", 0b100001, INSTR_IJ_TYPE},
    {"JLR",  0b100010, INSTR_IJ_TYPE},
    {"JLER", 0b100011, INSTR_IJ_TYPE}
};

//String array used to debug print
static const char *tokenTypes[] = {
    "STRING",
    "LABEL_DECLARE",
    "LABEL_INITIALIZE",
    "INSTRUCTION",
    "REGISTER",
    "IMMEDIATE",
    "COMMA",
    "S_OPEN_BRACKET",
    "S_CLOSE_BRACKET",
    "NEWLINE",
    "EOF",
    "INVALID"
};

//String array used to debug print
static const char *instructionTypes[] = {
    "NON_INSTR",
    "R_TYPE",
    "I_TYPE",
    "J_TYPE",
    "S_TYPE",
    "IJ_TYPE",
    "RT_TYPE",
    "RR_TYPE",
    "RI_TYPE"
};

TokenList *InitializeTokenList(void);

TokenNode *InitializeTokenNode(TokenType type, const char *value, size_t length, uint32_t memory);

void AddTokenList(TokenList *list, TokenType type, const char *value, size_t length, uint32_t memory);

void PrintTokenList(TokenList *list);

void FreeTokenList(TokenList *list);

char *ReadFile(const char *filename);

int SetMappedStringToken(TokenList *label_list, TokenNode *token);

void SetMemoryTokenList(TokenList *list);

int ParseToken(const char *source, TokenList *list, int position);

int Tokenize(const char *source, TokenList *list);

#endif // TOKENIZER_H