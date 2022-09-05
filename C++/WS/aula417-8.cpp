#include <stdio.h>
#define MAX 20

int tamStr(char s[]){
	if(s[0] == '\n') {s[0] = '\0';}
	printf("%p",&s[1]);
	return 1+ tamStr(&s[1]);
}

int main(){
	char texto[MAX];
	printf("Digite um texto de %d caracteres ", MAX);
	fgets(texto,MAX,stdin);
	printf("Tamanho da String = %d", tamStr(texto));
	return 0;
}
