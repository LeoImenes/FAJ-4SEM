#include <stdio.h>

int main(){
	struct {
		char ra[10];
		char nome[30];
	}aluno;
	
	 printf("RA: ");
	 fgets(aluno.ra,10,stdin);
	 printf("Nome: ");
	 fgets(aluno.nome,10,stdin);
	 printf("RA: %sNOME: %s", aluno.ra,aluno.nome);
	 return 0;
}
