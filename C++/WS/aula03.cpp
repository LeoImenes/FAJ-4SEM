#include <stdio.h>
#define MAX 2

void leString(char * texto, int m){
fgets(texto,m,stdin);
if(texto[0]=='\n'){
	fgets(texto,m,stdin);
	}
}

int main(){
struct{
char ra[12];
	char nome[32];
	float n1;
	float n2;
	
} lista[MAX];

int i;
for(i=0; i<MAX;i++){
	printf("RA: ");
	leString(lista[i].ra,12);
	printf("Nome: ");
	leString(lista[i].nome,32);
	printf("Nota1: ");
	scanf("%f" , lista[i].n1)
	printf("Nota2: ");
	scanf("%f" , lista[i].n2)
}
char sit;
float media;
for(i=0; i<MAX; i++){
	float media = (lista[i].n1 + lista[i].n2)/2.0;
	char sit;
	if(media>7){sit = a} else {sit = 'r'};
	}
	printf("RA: %sNome: %s, p1: %.2f, p2: %.2f, media: %.2f situacao %c \n", lista[i].ra, lista[i].nome)
return 0;
}
