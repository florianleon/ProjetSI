#define TAILLE 10

typedef struct {
    //int index;
    char* variable;
    int constante;
    int init;
} ligne;

ligne* creer(char* v, int c, int i);

void ajouter(ligne* l);

void enleverTmp();

void setInit(ligne* l);

int isInit(char* s);

uint32_t adresse(char* s);

void afficher();