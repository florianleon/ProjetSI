#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol_table_asm.h"


int table[TAILLE];


// début des fct //

// excécute une commande prenant 1 argument
void doubleVar(char* ordre, int addr){
    if( strcmp(ordre, "C") == 0 ){ // PRI
        printf("%d\n", table[addr]);
    }

}

// excécute une commande prenant 1 argument
void doubleOrdre(int ordre, int addr1, int addr2){

}

// excécute une commande prenant 2 arguments
void tripleOrdre(int ordre, int addr1, int addr2){
    if( ordre == 5 ){ // COP
        table[addr1] = table[addr2];
    }
    else if( ordre == 6 ){ // AFC
        table[addr1] = addr2;
    }

}

// excécute une commande prenant 3 arguments
void quadrupleOrdre(int ordre, int addr1, int addr2, int addr3){
    if( ordre == 1){ // ADD
        table[addr1] = table[addr2] + table[addr3];
    }
    else if( ordre == 2){ // MUL
        table[addr1] = table[addr2] * table[addr3];
    }
    else if( ordre == 3){ // SOU
        table[addr1] = table[addr2] - table[addr3];
    }
    else if( ordre == 4){ // DIV
        table[addr1] = table[addr2] / table[addr3];
    }

}



// debug
void afficher(){
    for(int i = 0; i<10; i++){
        printf("%d\t", table[i]);
    }
    printf("\n");
}