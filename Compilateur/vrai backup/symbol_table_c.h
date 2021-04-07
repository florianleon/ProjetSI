#define TAILLE 256                      // nombre max de variable 
#define TAILLE_TABLE_VARIABLE 10        // nombre max de declaration parallèle
#define MAX_INDENT 10                   // nombre max de "niveau de tabulation" (if dans for dans for dans if ...)
#define TAILLE_JUMP 100                 // nombre max de jump (while/if/else) dans le programme

typedef struct {
    char * variable;
    int constante;
    int init;
} ligne;

typedef struct {
    char* nom;   // else ; fif ; cloup ; floop ; loop
    int ouvert; // 1 -> ouvert ; 0 -> fermé
} jump;


// rajoute une variable déclarée sur une seul ligne à la liste
void ajouterListe(char* v);

// ajoute toutes les variables de la liste dans le tableau
void ajouter(int c, int i, FILE* fdClair, FILE* fdCode, int val);

// Augmente de 1 au niveau de la table d'indices
void ajouterIndent();

// Revient de 1 en arrière au niveau de la table d'indices
void enleverIndent();

// enlève la dernière variable temporaire
void enleverTmp();

// ajoute une variable temporaire
void ajouterTmp();

// retourne l'index de la dernière varibale temporaire
int derniereTmp();

// met à 1 le champs init d'une structure
void setInit(char* s);

// renvoie 1 si une variable donnée est initialisée
int isInit(char* s);

// renvoie l'index d'une varaible dans le tableau
int adresse(char* s);

// affiche le tableau
void afficher();

// Ecrit une opération donnée en asm
void ecrireOperationASM(FILE* fdClair, FILE* fdCode, int op, int tmp1, int tmp2);

// Assignation une variable temporaire à un nombre en asm
void assignerASM(FILE* fdClair, FILE* fdCode, char* v);

// assigne un nombre à une variable temporaire
void nbASM(FILE* fdClair, FILE* fdCode, int nb);

// assigne une adresse connue à une variable temporaire
void varASM(FILE* fdClair, FILE* fdCode, char* v);

// Ecrit la ligne print en ASM
void printASM(FILE* fdClair, FILE* fdCode, char* v);

// met la condition et le saut sur else si non respecté, en ASM (if 0)
void ifASM(FILE* fdClair, FILE* fdCode, int cmp);

// // Met la balise else en ASM (if 2)
void elseASM(FILE* fdClair, FILE* fdCode);

// Fait sauté le else (si on est rentré dans le if), en ASM (if 1)
void bifASM(FILE* fdClair, FILE* fdCode);

// Met la balise de fin du block if, en ASM (if 3)
void fifASM(FILE* fdClair, FILE* fdCode);

// ecrit la ligne de comparaison en ASM
void compareASM(FILE* fdClair, FILE* fdCode, int cmp);

// met la balise de debut du while en ASM (whil e0)
void dwhileASM(FILE* fdClair, FILE* fdCode);

// Fait sauté à la condition et met la balise de début de programme, en ASM (while 1)
void whileASM(FILE* fdClair, FILE* fdCode);

// Met la balise de condition, la condition et les sauts necessaires, en ASM (while 2)
void fwhileASM(FILE* fdClair, FILE* fdCode, int cmp);

// JUMP

// ajoute un jump au tableau
char* ajouterJump(char* nom);

//supprime un jump au tableau
char* supprimerJump(char* nom);
