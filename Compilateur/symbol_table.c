#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol_table.h"


ligne table[TAILLE];
int monIndex = 0;

char* tableVariable[TAILLE_TABLE_VARIABLE];
int varIndex = 0;

// début des fct //

ligne* creer(char * v, int c, int i){ // marche plus ???
    ligne* l;
        //strncpy(l->variable, tableVariable[j], TAILLE_VARIABLE-1);
        //l->variable[TAILLE_VARIABLE-1] = 0;
        l->variable = v;
        l->constante = c;
        l->init = i;

    return l;
}

// rajoute une variable déclarée sur une seul ligne à la liste
void ajouterListe(char* v){
    // si la liste n'est pas pleine on y ajoute la variable
    if(varIndex < TAILLE_TABLE_VARIABLE){
        // strcpy(tableVariable[varIndex], v); // if ...
        tableVariable[varIndex] = v;
        varIndex++;
    }
    // sinon on arrête tout
    else{
        printf("ERROR : Too many declartion : %d maximul\n", TAILLE_TABLE_VARIABLE);
        exit(1);
    }
}

// ajoute toutes les variables de la liste dans le tableau
void ajouter(int c, int i){
    //ligne * l = creer(v, c, i);
    
    // Pour chaque variable de la liste
    for(int j = 0; j < varIndex; j++){
        // on crée la ligne a ajouter
        ligne* l;
        //strncpy(l->variable, tableVariable[j], TAILLE_VARIABLE-1);
        //l->variable[TAILLE_VARIABLE-1] = 0;
        l->variable = tableVariable[j];
        l->constante = c;
        l->init = i;

        // on regarde si la varianle existe déjà
        int addr = adresse(tableVariable[j]);
        // on l'ajoute si elle n'exsite pas encore
        if( (monIndex < TAILLE) && (addr == -1) ){
            table[monIndex] = *l;
            ++monIndex;
        }
        // on change sa déclaration sinon (ou on arrête tout ?)
        else if( (monIndex < TAILLE) && (addr >= 0) ){
            table[addr] = *l;
            printf("WARNING : Variable already declared : %s\n", l->variable); // ERROR ?
        }
        // Sinon (si le tableau est plein) on arrête tout
        else{
            printf("ERROR : Heap full\n");
            exit(1);
        }
    }

    // on "efface" la liste
    varIndex = 0;

}

// Enlève le dernier élément du tableau
void enleverTmp(){
    monIndex--;

}

// enlève un élément donné du tableau
void enlever(char * s){
    // On récupère l'index de l'élément à supprimer
    int monIndex2 = adresse(s);

    // S'il n'existe pas on arrête tout
    if(monIndex2 == -1){
        printf("ERROR : remove non-existing variable : %s\n", s);
        exit(1);
    }

    // Sinon on décalle le tableau de 1 vers le bas
    for(int i = monIndex2; i < monIndex; i++){
        table[i]  = table[i+1];
    }

    // On décrémente l'index du tableau
    monIndex--;

}

// met à 1 le champs init d'une structure
void setInit(char* s){
    // on récupère l'adresse de la struct à modifier
    int addr = adresse(s);

    // si elle n'existe pas on arrête tout
    if(addr == -1){
        printf("ERROR : initialisation of a non-existing variable : %s\n", s);
        exit(1);
    }

    // si c'est une constante déjà instancié on arrête tout
    if( (table[addr].init == 1) && (table[addr].constante == 1) ){
        printf("ERROR : Constante already initialized : %s\n", s);
        exit(1);
    }

    // on marque la variable comme initialisé
    table[addr].init = 1;

}

// Renvoie 1 si une variable donnée est initialisée
int isInit(char* s){
    // On récupère l'index de la variable
    int addr = adresse(s);

    // Si elle n'existe pas on arrête tout
    if(addr == -1){
        printf("ERROR : variable does not exist : %s\n", s);
        exit(1);
    }

    // Sinon, on retourne son champs init
    return table[addr].init;

}

// renvoie l'index d'une varaible dans le tableau
int adresse(char* s){

    // On parcours le tableau initialisé
    for(int i=0; i<monIndex; i++){
        char* symbole = table[i].variable;
        // Si on rencontre la variable on retourne son index
        if(strcmp(s, symbole) == 0){
            return i;
        }
    }

    // Sinon, on retourne -1
    return (-1);

}

// affiche le tableau
void afficher(){
    // On affiche un entête au tableau
    printf("index\tnom\tconst\tinit\n");

    // On affiche chaque élément du tableau
    for(int i = 0; i<monIndex; i++){
        printf("%d\t%s\t%d\t%d\n", i, table[i].variable, table[i].constante, table[i].init);
    }
}