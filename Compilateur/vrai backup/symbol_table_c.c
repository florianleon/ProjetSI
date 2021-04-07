#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol_table_c.h"


ligne table[TAILLE];
int tmpIndex = TAILLE - 1;

int tableIndex[MAX_INDENT];
int indexIndex = 0;

char* tableVariable[TAILLE_TABLE_VARIABLE];
int varIndex = 0;

jump tableJump[TAILLE_JUMP];
int indexJump = 0;

char buf[10]; // bufer des labels


// début des fct //


// TABLEAU DE VARIABLE

// rajoute une variable déclarée sur une seul ligne à la liste
void ajouterListe(char* v){
    // si la liste n'est pas pleine on y ajoute la variable
    if(varIndex < TAILLE_TABLE_VARIABLE){
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
        if( (tableIndex[indexIndex] < tmpIndex) && ( (indexIndex == 0) || (addr < tableIndex[indexIndex - 1]) ) ){
            table[tableIndex[indexIndex]] = l;
            if (i == 1) {
                fprintf(fdClair, "\tCOP %d %d\n", tableIndex[indexIndex], valAddr);
                fprintf(fdCode, "\t5 %d %d\n", tableIndex[indexIndex], valAddr);
            }
            tableIndex[indexIndex] = tableIndex[indexIndex] + 1;
        }
        // on change sa déclaration sinon (ou on arrête tout ?)
        else if( (tableIndex[indexIndex] < tmpIndex) && ( ( (indexIndex == 0) && (addr >= 0) ) || ( (indexIndex !=0) && (addr >= tableIndex[indexIndex - 1]) ) ) ){
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

// INDENT

// Augmente de 1 au niveau de la table d'indices
void ajouterIndent(){
    if(tmpIndex == MAX_INDENT){
        printf("ERROR : Maximum indentation reached\n");
        exit(1);
    }

    indexIndex++;
    tableIndex[indexIndex] = tableIndex[indexIndex - 1];

}

// Revient de 1 en arrière au niveau de la table d'indices
void enleverIndent(){
    if(tmpIndex == 0){
        printf("ERROR : Already reached minimum indent\n");
        exit(1);
    }

    indexIndex--;
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
    if(tmpIndex <= tableIndex[indexIndex]){
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
    for(int i=0; i<tableIndex[indexIndex]; i++){
        char* symbole = table[tableIndex[indexIndex] - 1 - i].variable;
        // Si on rencontre la variable on retourne son index
        if(strcmp(s, symbole) == 0){
            return tableIndex[indexIndex] - 1 - i;
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
    for(int i = 0; i<tableIndex[indexIndex]; i++){
        printf("%d\t%s\t%d\t%d\n", i, table[i].variable, table[i].constante, table[i].init);
    }
}


// ASM

// Ecrit une opération donnée en asm
void ecrireOperationASM(FILE* fdClair, FILE* fdCode, int op, int tmp1, int tmp2){
    if( op == 1 ){
        fprintf(fdClair,"\tADD %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    else if( op == 2 ){
        fprintf(fdClair,"\tMUL %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    else if( op == 3 ){
        fprintf(fdClair,"\tSOU %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    else if( op == 4 ){
        fprintf(fdClair,"\tDIV %d %d %d\n", tmpIndex+2, tmpIndex+2, tmpIndex+1);
    }
    // On Ecrit l'opéaration "codé" en ASM
    fprintf(fdCode,"\t%d %d %d %d\n", op, tmpIndex+2, tmpIndex+2, tmpIndex+1);

    // on décrémente l'indice des variable temporaire de 1
    enleverTmp();
}

// Assignation une variable temporaire à un nombre en asm
void assignerASM(FILE* fdClair, FILE* fdCode, char* v){
    // on regarde si la variable existe déjà
    int addr = adresse(v);
    // on l'assigne si c'est le cas
    if( (addr != -1) ){
        // on arrête tout 
        if(tmpIndex != TAILLE-2){
            printf("ERROR : variable temporaire mal désempiler : %d\n", TAILLE - tmpIndex);
            exit(1);
        }
        // on écrit la ligne d'assignation
        fprintf(fdClair, "\tCOP %d %d\n", addr, tmpIndex+1);
        fprintf(fdCode, "\t5 %d %d\n", addr, tmpIndex+1);
        enleverTmp();
    }
    else{
        printf("ERROR : Assignation before declaration : %s\n", v);
        exit(1);
    }
}

// assigne un nombre à une variable temporaire
void nbASM(FILE* fdClair, FILE* fdCode, int nb){
    fprintf(fdClair, "\tAFC %d %d\n", tmpIndex, nb);
    fprintf(fdCode, "\t6 %d %d\n", tmpIndex, nb);
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
    fprintf(fdClair, "\tCOP %d %d\n", tmpIndex, addr);
    fprintf(fdCode, "\t5 %d %d\n", tmpIndex, addr);
    ajouterTmp();
}

// Print en ASM
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
        fprintf(fdClair, "\tPRI %d\n", addr);
        fprintf(fdCode, "\tC %d\n", addr);
    }
}

// ecrit la ligne de comparaison en ASM
void compareASM(FILE* fdClair, FILE* fdCode, int cmp){ //TODO cas composé avec jmp
    if(cmp == 0){ // inf
        fprintf(fdClair, "\tINF %d %d %d\n", tmpIndex + 2, tmpIndex + 2, tmpIndex + 1);
        fprintf(fdCode, "\t9 %d %d %d\n", tmpIndex + 2, tmpIndex + 2, tmpIndex + 1);
    }
    else if(cmp == 1){ // sup
        fprintf(fdClair, "\tSUP %d %d %d\n", tmpIndex + 2, tmpIndex + 2, tmpIndex + 1);
        fprintf(fdCode, "\tA %d %d\n", tmpIndex + 2, tmpIndex + 2, tmpIndex + 1);
    }
    else if(cmp == 2){ // égale
        fprintf(fdClair, "\tEQU %d %d %d\n", tmpIndex + 2, tmpIndex + 2, tmpIndex + 1);
        fprintf(fdCode, "\tB %d %d %d\n", tmpIndex + 2, tmpIndex + 2, tmpIndex + 1);
    }
    

    enleverTmp();
}

// IF

// met la condition et le saut sur else si non respecté, en ASM (if 0)
void ifASM(FILE* fdClair, FILE* fdCode, int cmp){
    compareASM(fdClair, fdCode, cmp);

    char* label = ajouterJump("else");
    fprintf(fdClair, "\tJMF %s\n", label);
    fprintf(fdCode, "\t8 %s\n", label);
}

// Met la balise else en ASM (if 2)
void elseASM(FILE* fdClair, FILE* fdCode){
    char* label = supprimerJump("else");
    fprintf(fdClair, "\n%s\n", label);
    fprintf(fdCode, "\n%s\n", label);
}

// Fait sauté le else (si on est rentré dans le if), en ASM (if 1)
void bifASM(FILE* fdClair, FILE* fdCode){
    char* label = ajouterJump("fif");
    fprintf(fdClair, "\tJMP %s\n", label);
    fprintf(fdCode, "\t7 %s\n", label);
}

// Met la balise de fin du block if, en ASM (if 3)
void fifASM(FILE* fdClair, FILE* fdCode){
    char* label = supprimerJump("fif");
    fprintf(fdClair, "\n%s\n\n\n", label);
    fprintf(fdCode, "\n%s\n\n\n", label);
}

// WHILE

// met la balise de debut du while en ASM (while 0)
void dwhileASM(FILE* fdClair, FILE* fdCode){
    char* label = ajouterJump("dloop");
    fprintf(fdClair, "\n%s\n", label);
    fprintf(fdCode, "\n%s\n", label);
}

// Fait sauté à la condition et met la balise de début de programme, en ASM (while 1)
void whileASM(FILE* fdClair, FILE* fdCode){
    // Saute à la condition
    char* label = ajouterJump("cloop");
    fprintf(fdClair, "\tJMP %s\n", label);
    fprintf(fdCode, "\t7 %s\n", label);

    // met le label de début de programme interne
    char* label2 = ajouterJump("loop");
    fprintf(fdClair, "\n%s\n", label2);
    fprintf(fdCode, "\n%s\n", label2);

}

// Met la balise de condition, la condition et les sauts necessaires, en ASM (while 2)
void fwhileASM(FILE* fdClair, FILE* fdCode, int cmp){
    // Saute au début du while, pour raffrachir les valeurs temporaires
    char* label = supprimerJump("dloop");
    fprintf(fdClair, "\tJMP %s\n", label);
    fprintf(fdCode, "\t7 %s\n", label);

    // met le label de début de condition
    char* label1 = supprimerJump("cloop");
    fprintf(fdClair, "\n%s\n", label1);
    fprintf(fdCode, "\n%s\n", label1);

    // ecrit la condition
    compareASM(fdClair, fdCode, cmp);

    // si non respecté on sort du loop
    char* label2 = ajouterJump("floop");
    fprintf(fdClair, "\tJMF %s\n", label2);
    fprintf(fdCode, "\t8 %s\n", label2);

    // si respecté on retourne y retourne
    char* label3 = supprimerJump("loop");
    fprintf(fdClair, "\tJMP %s\n", label3);
    fprintf(fdCode, "\t7 %s\n", label3);

    // met la balise de fin de while
    char* label4 = supprimerJump("floop");
    fprintf(fdClair, "\n%s\n\n\n", label4);
    fprintf(fdCode, "\n%s\n\n\n", label4);
}

// JUMP

// ajoute un jump au tableau
char* ajouterJump(char* nom){
    jump j;
    j.nom = nom;
    j.ouvert = 1;

    tableJump[indexJump] = j;
    
    snprintf(buf, 10, "%s%d", nom, indexJump);

    indexJump++;

    return buf;
}

//supprime un jump au tableau
char* supprimerJump(char* nom){

    for(int i = 0; i<indexJump; i++){
        if( (strcmp(tableJump[indexJump - 1 - i].nom, nom) == 0) && (tableJump[indexJump - 1 - i].ouvert == 1) ){
            snprintf(buf, 10, "%s%d", nom, indexJump - 1 - i);
            tableJump[indexJump - 1 - i].ouvert = 0;
            return buf;
        }
    }

    printf("ERROR : No \"jump\" to reach\n");
    exit(1);
}
