#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol_table.h"


ligne table[TAILLE];
int monIndex = 0;
int tmpIndex = TAILLE - 1;

char* tableVariable[TAILLE_TABLE_VARIABLE];
int varIndex = 0;

// début des fct //

ligne* creer(char * v, int c, int i){ // marche plus ???
    ligne* l;
        l->variable = v;
        l->constante = c;
        l->init = i;

    return l;
}

// TABLEAU DE VARIABLE

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
        printf("ERROR : Too many declartion : %d maximum\n", TAILLE_TABLE_VARIABLE);
        exit(1);
    }
}

// ajoute toutes les variables de la liste dans le tableau
void ajouter(int c, int i, FILE* fdClair, FILE* fdCode, int valAddr){
    // Pour chaque variable de la liste
    for(int j = 0; j < varIndex; j++){
        // on crée la ligne a ajouter
        ligne l;
        l.variable = tableVariable[j];
        l.constante = c;
        l.init = i;
        // on regarde si la varianle existe déjà
        int addr = adresse(tableVariable[j]);
        // on l'ajoute si elle n'exsite pas encore
        if( (monIndex < tmpIndex) && (addr == -1) ){
            table[monIndex] = l;
            if (i == 1) {
                fprintf(fdClair, "COP %d %d\n", monIndex, valAddr);
                fprintf(fdCode, "5 %d %d\n", monIndex, valAddr);
            }
            monIndex++;
        }
        // on change sa déclaration sinon (ou on arrête tout ?)
        else if( (monIndex < tmpIndex) && (addr >= 0) ){
            table[addr] = l;
            printf("ERROR : Variable already declared : %s\n", l.variable);
            exit(1);
        }
        // Sinon (si le tableau est plein) on arrête tout
        else{
            perror("Heap full\n");
            exit(1);
        }
    }
    // Si on a assigné les variables on supprime l'adresse temporaire
    if(i==1){
        enleverTmp();
    }
    
    // on "efface" la liste
    varIndex = 0;
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

// VARIABLE TEMPORAIRE

// enlève la dernière variable temporaire
void enleverTmp(){
    if(tmpIndex == TAILLE){
        printf("ERROR : Plus de variable temporaire à enlever");
        exit(1);
    }
    tmpIndex++;

}

// ajoute une variable temporaire
void ajouterTmp(){
    // on crée la structure
    ligne l;
    l.variable = "tmp";
    l.constante = 0;
    l.init = 0;

    // on l'ajoute à la suite
    table[tmpIndex] = l;

    // on met à jour l'index
    tmpIndex--;

    // on vérifie que la pile est toujours de la place
    if(tmpIndex <= monIndex){
        printf("ERROR : Pile pleine, Trop de variable temporaire\n");
        exit(1);
    }
}

// retourne l'index de la dernière varibale temporaire
int derniereTmp(){
    return tmpIndex+1;
}

// PRATIQUE

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

// ASM

// Ecrit une opération donnée en asm
void ecrireOperationASM(FILE* fdClair, FILE* fdCode, int op, int tmp1, int tmp2){
    if( op == 1 ){
        fprintf(fdClair,"ADD %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    else if( op == 2 ){
        fprintf(fdClair,"MUL %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    else if( op == 3 ){
        fprintf(fdClair,"SOU %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    else if( op == 4 ){
        fprintf(fdClair,"DIV %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    // On Ecrit l'opéaration "codé" en ASM
    fprintf(fdCode,"%d %d %d %d\n", op, tmpIndex+2, tmpIndex+2, tmpIndex+1);

    // on décrémente l'indice des variable temporaire de 1
    enleverTmp();
}

// Assignation une variable temporaire à un nombre en asm
void asignerASM(FILE* fdClair, FILE* fdCode, char* v){
    // on regarde si la variable existe déjà
    int addr = adresse(v);
    // on l'assigne si c'est le cas
    if( (addr != -1) ){
        // on arrête tout 
        if(tmpIndex != TAILLE-2){ // à verifier TODO (assigantion = dernière opération avant reset complet des tmp)
            printf("ERROR : variable temporaire mal désempiler : %d\n", TAILLE - tmpIndex);
            exit(1);
        }
        // on écrit la ligne d'assignation
        fprintf(fdClair, "COP %d %d\n", addr, tmpIndex+1);
        fprintf(fdCode, "5 %d %d\n", addr, tmpIndex+1);
        enleverTmp();
    }
    else{
        printf("ERROR : Assignation before declaration : %s\n", v);
        exit(1);
    }
}

// assigne un nombre à une variable temporaire
void nbASM(FILE* fdClair, FILE* fdCode, int nb){
    fprintf(fdClair, "AFC %d %d\n", tmpIndex, nb);
    fprintf(fdCode, "6 %d %d\n", tmpIndex, nb);
    ajouterTmp();

}

// assigne une adresse connue à une variable temporaire
void varASM(FILE* fdClair, FILE* fdCode, char* v){
    int addr = adresse(v);
    if(addr == -1){
        printf("ERROR : Usage before declaration : %s\n", v);
        exit(1);
    }
    if( table[addr].init != 1 ){
        printf("ERROR : Usage before assignation : %s\n", v);
        exit(1);
    }
    fprintf(fdClair, "COP %d %d\n", tmpIndex, addr);
    fprintf(fdCode, "5 %d %d\n", tmpIndex, addr);
    ajouterTmp();
}

// Ecrit la ligne print en ASM
void printASM(FILE* fdClair, FILE* fdCode, char* v){
    int addr = adresse(v);
    // si la variable n'existe pas on arrête tout
    if(addr == -1){
        printf("ERROR : Cannot print an undeclared variable : %s\n", v);
        exit(1);
    }
    // Si la variable n'a pas de valeur on arrête tout
    else if(table[addr].init == 0){
        printf("ERROR : Cannot print a variable without assignation : %s\n", v);
        exit(1);
    }
    // Sinon on crée le code associé
    else{
        fprintf(fdClair, "PRI %d\n", addr);
        fprintf(fdCode, "C %d\n", addr);
    }
}
