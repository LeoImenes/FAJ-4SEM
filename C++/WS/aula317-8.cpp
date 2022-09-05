#include <stdio.h>

int somaInteiro(int n){
	if(n==1) return (1);
	else return (n + somaInteiro(n-1));
}

int main(){
	int i;
	printf("Digite um numero: ");
	scanf("%d", &i);
	printf("Soma %d = %d \n", i, somaInteiro(i));
	
}
