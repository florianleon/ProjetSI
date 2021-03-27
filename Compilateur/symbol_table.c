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

    // on crée la ligne a ajouter
    ligne* l;
    strncpy(l->variable, v, TAILLE_VARIABLE-1);
    l->variable[TAILLE_VARIABLE-1] = 0;
    l->constante = c;
    l->init = i;

    
    int addr = adresse(v);
    if( (monIndex < TAILLE) && (addr == -1) ){
        table[monIndex] = *l;
        ++monIndex;
    }
    else if( (monIndex < TAILLE) && (addr >= 0) ){
        table[addr] = *l;
        printf("WARNING : Variable already declared\n");
    }
    else{
        printf("ERROR : Heap full\n");
        exit(1);
    }

}

void enleverTmp(){
    monIndex--;

}

void enlever(char * s){
    int monIndex2 = adresse(s);

    if(monIndex2 == -1){
        printf("ERROR : remove non-existing variable\n");
        exit(1);
    }

    for(int i = monIndex2; i < monIndex; i++){
        table[i]  = table[i+1];
    }
    monIndex--;

}

void setInit(char* s){
    int addr = adresse(s);
    if(addr == -1){
        printf("ERROR : initialisation of a non-existing variable\n");
        exit(1);
    }

    table[addr].init = 1;

}

int isInit(char* s){
    int addr = adresse(s);
    if(addr == -1){
        printf("ERROR : variable does not exist\n");
        exit(1);
    }
    return table[addr].init;

}

int adresse(char* s){

    for(int i=0; i<monIndex; i++){
        char* symbole = table[i].variable;
        if(strcmp(s, symbole) == 0){
            return i;
        }
    }

    return (-1);

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