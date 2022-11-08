/*
* Exemplo de Pilha com estrutura dinamica 
* pilhaDin01.c
*/

#include <stdio.h>
#include <malloc.h>

typedef int TIPOCHAVE;
typedef int boolean;

#define true 1
#define false 0 

typedef struct {
    TIPOCHAVE chave;
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

bool estaVazia(PILHA *p){
    if (p->topo == NULL) return true;
    return false;
}

void listarPilha(PILHA *p){
    PONT ender = p->topo;
    printf("\nPilha [ ");
    while (ender != NULL) {
        printf("%i ", ender-> reg.chave);
        ender = ender->prox;
    }
    printf("]\n");
}

bool pushElemPilha (PILHA *p, REGISTRO reg) {
    PONT novo = (PONT) malloc(sizeof(ELEMENTO));
    novo->reg = reg;
    novo->prox = p->topo;
    p->topo = novo;
    return true;
}

bool popElemPilha (PILHA *p, REGISTRO *reg) {
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

void leStr(char *texto, int max){
	fgets(texto,max,stdin);
	if(texto[0]=='\n'){
		fgets(texto,max,stdin);
		
	}
	int tam = strlen(texto) -1;
	if(texto[tam]== '\n'){
		texto [tam] ='\0';
	}
}

int main() {
    PILHA p1;
    REGISTRO r1;
    inicializaPilha(&p1);
    int op = 1;
    
    while (op){
    	printf("1 - Cadastrar: ");
    	printf("2 - remover elemento da pilha");
    	printf("3 - listar pilha");
    	printf("4 - tamanho pilha");
    	printf("5 - reiniciar pilha");
    	printf("Opcao: ");
    	scanf("%d", &op);
   	}
   	
    printf("tamanho da pilha: %d\n",tamanhoPilha(&p1));
    r1.chave = 10;
    pushElemPilha(&p1,r1);
    r1.chave = 20;
    pushElemPilha(&p1,r1);
    r1.chave = 40;
    pushElemPilha(&p1,r1);
    listarPilha(&p1);
    if (popElemPilha(&p1,&r1)) printf("elemento %d removido\n",r1.chave);
    printf("tamanho da pilha: %d\n",tamanhoPilha(&p1));
    listarPilha(&p1);
    reinicializarPilha(&p1);
    if (estaVazia(&p1)) printf("lista vazia\n") ;  
    return 0;
}
