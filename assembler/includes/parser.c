#include "parser.h"

char *int_to_binary(int num) {
    static char binary[33]; //Static buffer to store the binary string
    binary[32] = '\0';      //Null-terminate the string

    int i;
    for (i = 31; i >= 0; i--) {
        binary[i] = (num & 1) ? '1' : '0';
        num >>= 1;
    }

    return binary;
}

TokenNode *consume(TokenNode **token_node, TokenType expected) {
    //TokenNode *cur = list->head_token;

    if (token_node == NULL || (*token_node)->type != expected) {
        fprintf(stderr, "[-] Error: Expected token type %s, but got %s\n", tokenTypes[expected], tokenTypes[(*token_node)->type]);
        return NULL;
    }

    TokenNode *consumed = *token_node;
    (*token_node) = (*token_node)->next;
    return consumed;
}

// Parse instruction function
int ParseRTypeInstruction(TokenNode **token_node) {
    TokenNode *opcode = consume(token_node, TOKEN_INSTRUCTION);
    if (opcode == NULL) {
        return 1;
    }

    TokenNode *src1 = consume(token_node, TOKEN_REGISTER);
    if (src1 == NULL) {
        return 1;
    }

    consume(token_node, TOKEN_COMMA);

    TokenNode *src2 = consume(token_node, TOKEN_REGISTER);
    if (src2 == NULL) {
        return 1;
    }

    consume(token_node, TOKEN_COMMA);

    TokenNode *dest = consume(token_node, TOKEN_REGISTER);
    if (dest == NULL) {
        return 1;
    }

    uint32_t binary_out = (opcode->memory << 26) | (src1->memory << 21) | (src2->memory << 16) | (dest->memory << 11);
    printf("||| %s |||\n", int_to_binary(binary_out));

    return 0;
}

int ParseJTypeInstruction(TokenNode **token_node) {
    TokenNode *opcode = consume(token_node, TOKEN_INSTRUCTION);
    if (opcode == NULL) {
        return 1;
    }

    TokenNode *imm = consume(token_node, (*token_node)->type == TOKEN_IMMEDIATE ? TOKEN_IMMEDIATE : TOKEN_LABEL_INITIALIZE);
    if (imm == NULL) {
        return 1;
    }

    uint32_t binary_out = (opcode->memory << 26) | (imm->memory & 0x3FFFFFF);
    printf("||| %s |||\n", int_to_binary(binary_out));

    return 0;
}

int ParseSTypeInstruction(TokenNode **token_node) {
    TokenNode *opcode = consume(token_node, TOKEN_INSTRUCTION);
    if (opcode == NULL) {
        return 1;
    }

    uint32_t binary_out = (opcode->memory << 26);
    printf("||| %s |||\n", int_to_binary(binary_out));

    return 0;
}

int ParseInstruction(TokenNode **token_node) {
    InstructionType instruction_type = (*token_node)->instruction_type;

    switch (instruction_type) {
        case INSTR_R_TYPE: 
            return ParseRTypeInstruction(token_node);
            break;
        case INSTR_I_TYPE:
            break;
        case INSTR_J_TYPE:
            return ParseJTypeInstruction(token_node);
            break;
        case INSTR_S_TYPE:
            return ParseSTypeInstruction(token_node);
            break;
    }

    return 0;
}

// Main parsing function
void ParseTokenList(TokenList *list) {
    TokenNode *cur = list->head_token;

    size_t line_count = 1;

    while (cur != NULL && cur->type != TOKEN_EOF) {

        if (cur->type == TOKEN_INSTRUCTION) {
            if (ParseInstruction(&cur)) {
                fprintf(stderr, "[-] Error: Invalid instruction format '%s' at line '%ld'\n", cur->value, line_count);
                return;
            }
        } 

        else if (cur->type == TOKEN_NEWLINE) {
            line_count++;
            consume(&cur, TOKEN_NEWLINE);
        }

        else if (cur->type == TOKEN_LABEL_DECLARE) {
            consume(&cur, TOKEN_LABEL_DECLARE);
        }
        
        else {
            fprintf(stderr, "[-] Error: Unexpected token '%s' at line '%ld'\n", tokenTypes[cur->type], line_count);
            return;
        }
    }
}