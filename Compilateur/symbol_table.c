#include <stdlib.h>
#include <stdio.h>
#include "symbole_table.h"


ligne table[TAILLE];
int index = 0;

// début des fct //

ligne* creer(char* v, int c, int i){
    ligne* l;
    //l->index = index;
    l->variable = v;
    l->constante = c;
    l->init = i;

    return l;
}

void ajouter(ligne* l){
    table[index] = *l;
    index++;

}

void enleverTmp(l){
    index--;

}

void setInit(char* s){
    int addr = adresse(s);
    table[addr]->init = 1;

}

int isInit(char* s){
    int addr = adresse(s);
    return table[addr]->init;

}

int adresse(char* s){

    for(int i=0; i<INDEX; i++){
        char* symbole = table[i]->variable;
        if(strcmp(s, symbole) == 0){
            return i;
        }
    }

    printf("init avant decl\n");
    exit(1);

}

void afficher(){
    char* variable;
    int constante;
    int init;

    printf("index\tnom\tconst\tinit\n");

    for(int i = 0; i<index; i++){
        variable = table[i]->variable;
        constante = table[i]->constante;
        init = table[i]->init;
        printf("%d\t%s\t%d\t%d\n", i, variable, constante, init);
    }
}