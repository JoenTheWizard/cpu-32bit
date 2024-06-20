#ifndef PARSER_H
#define PARSER_H

#include "tokenizer.h"

char *int_to_binary(int num);

TokenNode *consume(TokenNode **token_node, TokenType expected);

//Parse instruction function
int ParseInstruction(TokenNode **token_node);

//Main parsing function
void ParseTokenList(TokenList *list);

#endif // PARSER_H