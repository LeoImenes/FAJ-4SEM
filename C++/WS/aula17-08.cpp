#include <stdio.h>

int main(){
	int i = 5;
	while(i){
		printf("%d", i);
		i--;
	}
	
	printf("\n");
	i=3;
	
	do{
	   printf("%d", i);
		i--;
	}while(i);
	
	return 0;
	
	
}
