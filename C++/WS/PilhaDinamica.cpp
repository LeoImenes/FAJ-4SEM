#include <stdio.h>
#include <malloc.h>

typedef int TIPOCHAVE;
typedef int boolean;

#define true 1
#define false 0 

typedef struct {
    TIPOCHAVE chave;
    int ra;
    float nota1,nota2;
    char nome[60];
    // outros campos ...
} REGISTRO;

typedef struct aux {
    REGISTRO reg;
    struct aux *prox;
} ELEMENTO;

typedef ELEMENTO *PONT;

typedef struct {
    PONT topo;
} PILHA;    

void leStr(char *texto, int max)
{
    fgets(texto, max, stdin);
    if (texto[0] == '\n')
        fgets(texto, max, stdin);
    int tam = strlen(texto) - 1;
    if (texto[tam] == '\n')
        texto[tam] = '\0';
}

void inicializaPilha (PILHA *p) {
    p->topo = NULL;
}

int tamanhoPilha(PILHA *p){
    PONT ender = p-> topo;
    int tam = 0;
    while (ender != NULL) {
        tam++;
        ender = ender->prox;
    }
    return tam;
}

boolean estaVazia(PILHA *p){
    if (p->topo == NULL) return true;
    return false;
}

void listarPilha(PILHA *p){
    PONT ender = p->topo;
    printf("Pilha [ ");
    while (ender != NULL) {
        printf("%i ", ender-> reg.chave);
        ender = ender->prox;
    }
    printf("]\n");
}

boolean pushPilha (PILHA *p, REGISTRO reg) {
    PONT novo = (PONT) malloc(sizeof(ELEMENTO));
    novo->reg = reg;
    novo->prox = p->topo;
    p->topo = novo;
    return true;
}

boolean popPilha (PILHA *p, REGISTRO *reg) {
    if (p->topo == NULL) return false;
    *reg = p->topo->reg;
    PONT apagar = p->topo;
    p->topo = p->topo->prox;
    free(apagar);
    return true;
}

void reinicializarPilha( PILHA *p) {
    PONT apagar;
    PONT posicao = p->topo;
    while(posicao != NULL){
        apagar = posicao;
        posicao = posicao->prox;
        free(apagar);
    }
    p->topo = NULL;
}

int main() {
    PILHA p1;
    REGISTRO reg1;
    inicializaPilha (&p1);
    int op = 1;
    char cont;
    while (op){
        printf("\n\n");
        printf("1- Inserir\n");
        printf("2- Excluir\n");
        printf("3- Listar\n");
        printf("4- Reinicializar\n");
        printf("5- Tamanho da pilha\n");
        printf("0- Finalizar\n");
        printf("Opcao: ");
        scanf("%d",&op);
        switch (op){
            case 1 :printf("\n\nDigite o elemento a ser inserido : "); 
                    scanf("%d",&reg1.chave);
                    pushPilha(&p1,reg1);
                    break;
            case 2 :if (popPilha(&p1,&reg1)) {
                        printf("\n\nElemento excluido: pop(%d)\n",reg1.chave);
                    } else {printf("\n\nErro, pilha vazia ");} 
                    break;
            case 3 :listarPilha(&p1); getchar(); break;
            case 4 : printf("Todos os dados serão perdidos, continua (y/n) ? ");
                    scanf(" %c",&cont); if (cont=='y' || cont == 'Y') reinicializarPilha(&p1);
                    break;
            case 5 :printf("\n\ntamanho da pilha %d \n",tamanhoPilha(&p1)); 
            break;
            case 0 :printf("\n\nHasta la vista, Baby\n\n");
                    break;
            default :printf("\nOpcao invalida\n");
        }
    }
    return 0;
}
