typedef int boleano;
#include <stdio.h>
#define MAX 10
typedef int ficha;

void quicksort(ficha values[], int began, int end)
{
	ficha aux,pivo; 
	int i, j;
	i = began;
	j = end-1;
	pivo = values[(began + end) / 2];
	while(i <= j)	{
		while(values[i].ra < pivo.ra && i < end)		{
			i++;
		}
		while(values[j].ra > pivo.ra && j > began)		{
			j--;
		}
		if(i <= j)		{
			aux = values[i];
			values[i] = values[j];
			values[j] = aux;
			i++;
			j--;
		}
	}
	if(j > began)
		quicksort(values, began, j+1);
	if(i < end)
		quicksort(values, i, end);
}

void impVetor(ficha *v){
    printf ("{");
    for (int i =0; i< MAX;i++) 
        printf("%d ",v[i]);
    printf("}\n\n");
}




int main(){
	ficha fichario[MAX] = {5, 8, 1, 2, 7, 3, 6, 9, 4, 10};
	printf("\nVetor original\n ");
	impVetor(fichario);	
	printf("\n\nVetor Ordenado (quicksort)\n");
	quicksort(fichario, 0, MAX);
	impVetor(fichario);
	return 0;
}


