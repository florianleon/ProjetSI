#define TAILLE 256
#define TAILLE_TABLE_VARIABLE 10

typedef struct {
    char * variable;
    int constante;
    int init;
} ligne;

ligne* creer(char* v, int c, int i); // inutile ?

// rajoute une variable déclarée sur une seul ligne à la liste
void ajouterListe(char* v);

// ajoute toutes les variables de la liste dans le tableau
void ajouter(int c, int i, FILE* fdClair, FILE* fdCode, int val);

// enlève un élément donné du tableau
void enlever(char * s);

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
void asignerASM(FILE* fdClair, FILE* fdCode, char* v);

// assigne un nombre à une variable temporaire
void nbASM(FILE* fdClair, FILE* fdCode, int nb);

// assigne une adresse connue à une variable temporaire
void varASM(FILE* fdClair, FILE* fdCode, char* v);







void a();
