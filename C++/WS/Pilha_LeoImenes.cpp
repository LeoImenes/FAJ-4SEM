#include <stdio.h>
#include <string.h>

#define MAX 3
#define MAX_NOME 60

#define true 1
#define false 0

typedef int boolean;
typedef int TIPOCHAVE;

typedef struct {
    TIPOCHAVE chave;
    char nome[MAX_NOME];
    float nota1,nota2;
} REGISTRO;

typedef struct {
    REGISTRO A[MAX];
    int inicio;
    int nroElem;
} FILA;


void inicializarFila(FILA *f){
    f->inicio = 0;
    f->nroElem = 0;
}

int tamanhoFila(FILA *f) {
    return f->nroElem;
}

void listarFila (FILA *f){
    printf("\n\nFila:  \n");
    int i = f->inicio;
    int temp;
    for(temp = 0; temp < f->nroElem; temp++){
        printf("| %4i|%-4s|%4.1f|%4.1f |\n", 
        f->A[i].chave,f->A[i].nome,f->A[i].nota1,f->A[i].nota2);
        i = (i+1) % MAX; 
    }
}

boolean inserirElemFila(FILA *f, REGISTRO reg) {
   if (f->nroElem >= MAX) return false;
   int posicao = (f->inicio + f->nroElem) % MAX;
   f->A[posicao] = reg;
   f->nroElem++;
   return true; 
}

boolean excluirElementoFila(FILA *f, REGISTRO *reg){
    if (f->nroElem == 0) return false;
    *reg = f->A[f->inicio];
    f->inicio = (f->inicio+1) % MAX;
    f->nroElem--;
    return true;
}

void reinicializaFila(FILA *f){
    inicializarFila(f);
}

void leStr(char *texto, int max ){
    fgets(texto,max,stdin);
    if (texto[0]=='\n')
        fgets(texto,max,stdin);
    int tam = strlen(texto)-1;
    if (texto[tam]=='\n')
        texto[tam] = '\0';
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
        printf("5- Tamanho da pilha\n");
        printf("0- Finalizar\n");
        printf("Opcao: ");
        scanf("%d",&op);
        switch (op){
            case 1: 
            printf("Informe o Nome: \n");
            leStr(reg1.nome,MAX_NOME);
            printf("Informe a N1: ");
            scanf("%f",&reg1.nota1);
            printf("Informe a N2: ");
            scanf("%f",&reg1.nota2);
            if(inserirElemFila(&f1,reg1)) printf("\nSucesso\n");
            else printf("\nErro, fila cheia\n");
            break;
            case 2:
            	if (excluirElementoFila(&f1,&reg1)) {
                        printf("Elemento Excluido");
                    } 
                    break;
            case 3:
            	listarFila(&f1); getchar();
            	break;
           	case 4:
           		reinicializaFila(&f1);
      		case 5 :
      			if(tamanhoFila(&f1) == 0){
      				printf("Lista Vazia");
				  }else{
				  	tamanhoFila(&f1);
				  }
      			break;
   			case 0 :
   				break;
			default: break;	
        }
    }
    return 0;
}


