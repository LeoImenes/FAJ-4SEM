#include <stdio.h>

typedef struct{
	int ra;
	char nome[30];
}tipoAluno;

void leString(char *texto, int m){
	fgets(texto,m,stdin);
	if(texto[0]=='\n'){
		fgets(texto,m,stdin);
	}
}

void leEstru (tipoAluno *al){
	printf("RA: ");
	scanf("%d", &al->ra);
	printf("Nome: ");
	leString(al->nome,30);
}

void impestru (tipoAluno *al){
	printf("\n\n Listagem \n\n");
	printf("RA: %d Nome: %s", al->ra,al->nome);
}

int main(){
	tipoAluno aluno;
	leEstru(&aluno);
	impestru(&aluno);
	return 0;
}
