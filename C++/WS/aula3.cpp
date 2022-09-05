#include <stdio.h>
#define MAX 3
#define true 1
#define false 0

typedef int boolean; 
typedef int TIPOCHAVE;

typedef struct {
    TIPOCHAVE chave;
    // outros campos 
} REGISTRO;

typedef struct {
    REGISTRO A[MAX];
    int topo;
} PILHA;

void inicializaPilha (PILHA *p){
    p->topo = -1;
}

int tamanhoPilha(PILHA *p) {
    return p->topo+1;
}

void listarPilha(PILHA *p){
    printf("Pilha [");
    int i;
    for (i= p->topo;i>=0;i--){
        printf("%i ", p->A[i].chave);
    }
    printf("]\n");
}

boolean pushPilha(PILHA *p, REGISTRO reg){
    if (p->topo >=  MAX -1) return false;
    p->topo = p-> topo+1;
    p->A[p->topo] = reg;
    //printf("push(%d) posicao %d\n",reg.chave,p->topo+1);
    return true;
}

boolean popPilha (PILHA *p, REGISTRO *reg){
    if (p->topo == -1) return false;
    *reg = p->A[p->topo];
    p->topo = p-> topo -1;
    return true;
}

void reinicializaPilha(PILHA *p) {
    p->topo = -1;
}

int main() {
	int op = -1;
		PILHA p1;
        REGISTRO reg1;
        inicializaPilha(&p1);
   while(op != 0 ){	
   		printf("\n\n");
        printf("1- Inserir \n");
        printf("2- Excluir\n");
        printf("3- Listar\n");
        printf("4- Tamanho da pilha\n");
        printf("5- Consulta\n");
        printf("6- Reinicializar\n");
        printf("0- Finalizar\n");
        printf("Opcao: ");
        scanf("%d",&op);
  
	        
        switch(op){
        	
        	case 1:
        		printf("Informe o numero: ");
        		scanf("%d", &reg1.chave);
   		     	pushPilha(&p1, reg1);
   		     	
        		break;
        	case 2:
	 			 popPilha(&p1, &reg1);
       		
       		case 3:
       			listarPilha(&p1);
       			break;
       			
   			case 4:
   				tamanhoPilha(&p1);
   				break;
       			
			case 6:
				 reinicializaPilha(&p1);
				 break;
				 	
			
			case 0:
				break;
		}
        	
   }
}
