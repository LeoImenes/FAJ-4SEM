#include <stdio.h>

#define MAX 3

int main(){
    int vet[MAX],i;
    for(i=0;i<MAX;i++){
        printf("Digite(%d): ", i);
        scanf("%d",&vet[i]);
    }
    printf("\n\nImprimindo vetor\n\n");
    for (i=0; i<MAX; i++){
        printf("Posição (%d) %d\n", i,vet[i]);
    }
    return 0;
}