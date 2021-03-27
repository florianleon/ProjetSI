#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol_table.h"


ligne table[TAILLE];
int monIndex = 0;

// début des fct //

ligne* creer(char* v, int c, int i){ // marche plus ???
    ligne* l;

    strncpy(l->variable, v, TAILLE_VARIABLE-1);
    //l->variable[TAILLE_VARIABLE-1] = 0;
    l->constante = c;
    l->init = i;

    return l;
}

void ajouter(char* v, int c, int i){
    //ligne * l = creer(v, c, i);

    ligne* l;

    strncpy(l->variable, v, TAILLE_VARIABLE-1);
    //l->variable[TAILLE_VARIABLE-1] = 0;
    l->constante = c;
    l->init = i;

    if(monIndex < TAILLE){
        table[monIndex] = *l;

        ++monIndex;
    }

}

void enleverTmp(){
    monIndex--;

}

void enlever(char * s){
    int monIndex2 = adresse(s);

    for(int i = monIndex2; i < monIndex; i++){
        table[i]  = table[i+1];
    }
    monIndex--;

}

void setInit(char* s){
    int addr = adresse(s);
    table[addr].init = 1;

}

int isInit(char* s){
    int addr = adresse(s);
    return table[addr].init;

}

int adresse(char* s){

    for(int i=0; i<monIndex; i++){
        char* symbole = table[i].variable;
        if(strcmp(s, symbole) == 0){
            return i;
        }
    }

    printf("initialisation avant declaration\n");
    exit(1);

}

void afficher(){
    char* variable;
    int constante;
    int init;

    printf("index\tnom\tconst\tinit\n");

    for(int i = 0; i<monIndex; i++){
        variable = table[i].variable;
        constante = table[i].constante;
        init = table[i].init;
        printf("%d\t%s\t%d\t%d\n", i, variable, constante, init);
    }
}