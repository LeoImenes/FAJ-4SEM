#include <stdio.h>

int expo(int x, int y){
	if(y==0) return 1;
	if(y==1)return x;
	return x * expo(x,y-1);
}


int main(){
	int x,y;
	printf("Digite x");
	scanf("%d", &x);
	printf("Digite y: ");
	scanf("%d", &y);
	printf("%d", expo(x,y));
}
