#define TAILLE 256
#define TAILLE_VARIABLE 256

typedef struct {
    //int index;
    char variable[TAILLE_VARIABLE];
    int constante;
    int init;
} ligne;

ligne* creer(char* v, int c, int i);

void ajouter(char* v, int c, int i);

void enleverTmp();

void enlever(char * s);

void setInit(char* s);

int isInit(char* s);

int adresse(char* s);

void afficher();