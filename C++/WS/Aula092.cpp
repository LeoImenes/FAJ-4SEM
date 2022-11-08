#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
	   int ra;
	   char nome[30];
}tipoficha;


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

int main(){
	tipoficha *fichario;
	int tam;
	printf("Quantas elemento sero armazenados: ");
	scanf("%d", &tam);
	fichario = (tipoficha *)malloc(sizeof(tipoficha) * tam);
	int i;
	for(i=0;i<tam;i++){
		printf("ra: "); scanf("%d", &fichario[i].ra);
		printf("Nome: "); leStr(fichario[i].nome,30);		
	}
	printf("Listagem");
	for(i=0;i<tam;i++){
		printf("Ra %d nome %s", fichario[i].ra, fichario[i].nome);
		
	}
	free(fichario);
	return 0;
}
