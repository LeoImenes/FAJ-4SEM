
#include <stdio.h>
#include <malloc.h>
#include <string.h>

#define true 1
#define false 0;

typedef int TIPOCHAVE;
typedef int boolean;

typedef struct {
    TIPOCHAVE chave; 
    int ra;
    char nome[60];
    float nota1,nota2;
    // outros campos ...
} REGISTRO;

typedef struct aux {
    REGISTRO reg;
    struct aux *prox;
} ELEMENTO, *PONT;

typedef struct {
    PONT inicio;
    PONT fim;
} FILA;

void leStr(char *texto, int max)
{
    fgets(texto, max, stdin);
    if (texto[0] == '\n')
        fgets(texto, max, stdin);
    int tam = strlen(texto) - 1;
    if (texto[tam] == '\n')
        texto[tam] = '\0';
}

void inicializarFila(FILA *f) {
    f->inicio=NULL;
    f->fim=NULL;
}

int tamanhoFila(FILA *f){
    PONT ender = f->inicio;
    int tam = 0;
    while (ender != NULL) {
        tam++;
        ender = ender -> prox;
    }
    return tam;
}

void listaFila(FILA *f) {
    PONT ender = f->inicio;
    printf("Fila [ ");
    while (ender != NULL) {
         printf("\n\nListagem da Pilha \n\n");
    printf("|-----------|------------------------------------------------------------|----|----|-----|\n");
    printf("|    RA     |                     Nome                                   | P1 | P2 |media|\n");
    printf("|-----------|------------------------------------------------------------|----|----|-----|\n");
 

        printf("| %10i|%-60s|%4.1f|%4.1f|%4.1f |\n", 
        ender->reg.chave,ender->reg.nome,ender->reg.nota1,ender->reg.nota2,(ender->reg.nota1+ender->reg.nota2)/2);
 

    printf("|-----------|------------------------------------------------------------|----|----|-----|\n");
    }
    printf("]\n");
}

boolean inserirFila(FILA *f, REGISTRO reg) {
    PONT novo = (PONT) malloc(sizeof(ELEMENTO));
    novo->reg = reg;
    novo->prox = NULL;
    if (f->inicio==NULL) f->inicio=novo;
    else f->fim->prox = novo;
    f->fim = novo;
    return true;
}

boolean excluirFila( FILA *f, REGISTRO *reg){
    if (f->inicio== NULL) return false;
    *reg = f->inicio->reg;
    PONT apagar = f->inicio;
    f->inicio = f->inicio->prox;
    free(apagar);
    if (f->inicio==NULL) f->fim=NULL;
    return true;
}

void reinicializaFila (FILA *f) {
    PONT ender = f->inicio;
    while (ender != NULL){
        PONT apagar = ender;
        ender = ender->prox;
        free(apagar);
    }
    f->inicio=NULL;
    f->fim=NULL;
}

int main() {
    FILA f1;
    REGISTRO reg1;
    inicializarFila(&f1);
    int op = 1;
    char cont;
    while (op){
        printf("\n\n");
        printf("1- Inserir\n");
        printf("2- Excluir\n");
        printf("3- Listar\n");
        printf("4- Reinicializar\n");
        printf("5- Tamanho da fila\n");
        printf("0- Finalizar\n");
        printf("Opcao: ");
        scanf("%d",&op);
        switch (op){
            case 1 :printf("\n\nDigite o ra a ser inserido : "); 
                    scanf("%d", &reg1.ra);
                    printf("\n\nDigite o nome a ser inserido : "); 
                    leStr(reg1.nome, 60);
                    printf("\n\nDigite a primeira nota a ser inserido : ");
                    scanf("%f",&reg1.nota1);
					printf("\n\nDigite a segunda nota a ser inserido : ");
                    scanf("%f",&reg1.nota2);
                    inserirFila(&f1,reg1);
                    break;
            case 2 :if (excluirFila(&f1,&reg1)) {
                        printf("\n\nElemento excluido: pop(%d)\n",reg1.ra);
                    } else {printf("\n\nErro, pilha vazia ");} 
                    break;
            case 3 :listaFila(&f1); getchar(); break;
            case 4 : printf("Todos os dados serão perdidos, continua (y/n) ? ");
                    scanf(" %c",&cont); if (cont=='y' || cont == 'Y') reinicializaFila(&f1);
                    break;
            case 5 :printf("\n\ntamanho da pilha %d \n",tamanhoFila(&f1)); 
            break;
            case 0 :printf("\n\nHasta la vista, Baby\n\n");
                    break;
            default :printf("\nOpcao invalida\n");
        }
    }
    return 0;
}

