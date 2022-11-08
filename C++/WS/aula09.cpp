#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>

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
	char *nome;
	int tam;
	printf("Quantos caracteres tem na string: ");
	scanf("%d", &tam);
	nome = (char *) malloc(sizeof(char) * tam);
	printf("Nome: ");
	leStr(nome,tam);
	printf("Voce digitou %s" , nome);
	free(nome);
//	int *vet;
//	int i, tamanho;
//	
//	printf("Tamanho do vetor: ");
//	scanf("%d", &tamanho);
//	vet = (int *)malloc(sizeof(vet)*tamanho);
//	//carga no vetor
//	for(i=0;i<tamanho;i++){
//	vet[i] = i+10;
//	 printf("%d,", vet[i]);	
//	} 
//	free(vet); //libera memoris
	return 0;
}
