#include <stdio.h>

int main(){
	int op = 1,i;
	int num[3];
	
	while (op != 0){
		printf("1 - Cadastrar \n");
		printf("2 - Listar \n");
		printf("0 - Fim \n");
		printf("opcao: "); scanf("%d", &op);
		switch (op){
			case 0: printf("Xau");
			break;
			case 1:
				for(i=0;i<3;i++){
					printf("%d) numero: ", i); scanf("%d", &num[i]);
				}
				break;
			case 2:
					for(i=0;i<3;i++){
					printf("%d) numero: %d \n", i,num[i]);
				
				}
					getchar();
				break;
			default: printf("Invalido");
			
		}
	}
}
