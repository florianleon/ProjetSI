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

void ajouterListe(char* v);

void ajouter(int c, int i);

void enleverTmp();

void enlever(char * s);

void setInit(char* s);

int isInit(char* s);

int adresse(char* s);

void afficher();