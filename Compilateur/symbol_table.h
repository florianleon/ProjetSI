#define TAILLE 256
//#define TAILLE_VARIABLE 20
#define TAILLE_TABLE_VARIABLE 10

typedef struct {
    //int index;
    char * variable; //[TAILLE_VARIABLE];
    int constante;
    int init;
} ligne;

ligne* creer(char* v, int c, int i); // inutile ?

// rajoute une variable déclarée sur une seul ligne à la liste
void ajouterListe(char* v);

// ajoute toutes les variables de la liste dans le tableau
void ajouter(int c, int i);

// enlève le dernier éléments du tableau
void enleverTmp();

// enlève un élément donné du tableau
void enlever(char * s);

// met à 1 le champs init d'une structure
void setInit(char* s);

// renvoie 1 si une variable donnée est initialisée
int isInit(char* s);

// renvoie l'index d'une varaible dans le tableau
int adresse(char* s);

// affiche le tableau
void afficher();