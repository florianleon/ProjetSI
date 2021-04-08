/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tAO = 259,
    tAF = 260,
    tINT = 261,
    tCONST = 262,
    tPO = 263,
    tPF = 264,
    tESPACE = 265,
    tV = 266,
    tPV = 267,
    tPRINT = 268,
    tNB = 269,
    tEXP = 270,
    tVAR = 271,
    tET = 272,
    tNE = 273,
    tSE = 274,
    tIE = 275,
    tST = 276,
    tIT = 277,
    tIF = 278,
    tELSE = 279,
    tWHILE = 280,
    tMUL = 281,
    tEQ = 282,
    tADD = 283,
    tSUB = 284,
    tDIV = 285
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tAO 259
#define tAF 260
#define tINT 261
#define tCONST 262
#define tPO 263
#define tPF 264
#define tESPACE 265
#define tV 266
#define tPV 267
#define tPRINT 268
#define tNB 269
#define tEXP 270
#define tVAR 271
#define tET 272
#define tNE 273
#define tSE 274
#define tIE 275
#define tST 276
#define tIT 277
#define tIF 278
#define tELSE 279
#define tWHILE 280
#define tMUL 281
#define tEQ 282
#define tADD 283
#define tSUB 284
#define tDIV 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 14 "AnalyseurGrammaticalC.y"

    char *variable;
    int nombre;

#line 122 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
