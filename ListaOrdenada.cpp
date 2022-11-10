#include <stdio.h>
#include <malloc.h>

typedef int TIPOCHAVE;
typedef int boolean;

#define true 1
#define false 0

typedef struct
{
    TIPOCHAVE chave;
    char nome[60];
    int ra;
    float nota1,nota2;
} REGISTRO;

typedef struct aux
{
    REGISTRO reg;
    struct aux *prox;
} ELEMENTO;

typedef ELEMENTO *PONT;

typedef struct
{
    PONT inicio;
} LISTA;

void inicializarLista(LISTA *l)
{
    l->inicio = NULL;
}

int tamanho(LISTA *l)
{
    PONT ender = l->inicio;
    int tam = 0;
    while (ender != NULL)
    {
        tam++;
        ender = ender->prox;
    }
    return tam;
}

void listar(LISTA *l)
{
    PONT ender = l->inicio;
    printf("Fila [ ");
    while (ender != NULL) {
         printf("\n\nListagem da Pilha \n\n");
    printf("|-----------|------------------------------------------------------------|----|----|-----|\n");
    printf("|    RA     |                     Nome                                   | P1 | P2 |media|\n");
    printf("|-----------|------------------------------------------------------------|----|----|-----|\n");
 

        printf("| %10i|%-60s|%4.1f|%4.1f|%4.1f |\n", 
        ender->reg.chave,ender->reg.nome,ender->reg.nota1,ender->reg.nota2,(ender->reg.nota1+ender->reg.nota2)/2);
 

    printf("|-----------|------------------------------------------------------------|----|----|-----|\n");
    }
    printf("]\n");
}


PONT buscaSeqListaOrd(LISTA *l, TIPOCHAVE ch, PONT *ant)
{
    *ant = NULL;
    PONT atual = l->inicio;
    while ((atual != NULL) && (atual->reg.chave < ch))
    {
        *ant = atual;
        atual = atual->prox;
    }
    if ((atual != NULL) && (atual->reg.chave == ch))
        return atual;
    return NULL;
}

boolean inserirElemListaOrd(LISTA *l, REGISTRO reg)
{
    TIPOCHAVE ch = reg.chave;
    PONT ant, pos;
    pos = buscaSeqListaOrd(l, ch, &ant);
    if (pos != NULL)
        return false; // elemento repetido;
    pos = (PONT)malloc(sizeof(ELEMENTO));
    pos->reg = reg;
    if (ant == NULL)
    {
        pos->prox = l->inicio;
        l->inicio = pos;
    }
    else
    {
        pos->prox = ant->prox;
        ant->prox = pos;
    }
    return true;
}

boolean excluirElementoLista(LISTA *l, TIPOCHAVE ch)
{
    PONT ant, pos;
    pos = buscaSeqListaOrd(l, ch, &ant);
    if (pos == NULL)
        return false; // elemento nao encontrado
    if (ant == NULL)
        l->inicio = pos->prox;
    else
        ant->prox = pos->prox;
    free(pos);
    return true;
}

boolean estaVazia(LISTA *l)
{
    return l->inicio == NULL;
}

void reinicializarLista(LISTA *l)
{
    PONT ender = l->inicio;
    while (ender != NULL)
    {
        PONT apagar = ender;
        ender = ender->prox;
        free(apagar);
    }
    l->inicio = NULL;
}

int main()
{
    LISTA l;
    REGISTRO r1;
    inicializarLista(&l);
       case 1 :printf("\n\nDigite o ra a ser inserido : "); 
                    scanf("%d", &r1.ra);
                    printf("\n\nDigite o nome a ser inserido : "); 
                    leStr(r1.nome, 60);
                    printf("\n\nDigite a primeira nota a ser inserido : ");
                    scanf("%f",&r1.nota1);
					printf("\n\nDigite a segunda nota a ser inserido : ");
                    scanf("%f",&r1.nota2);
                    inserirFila(&l,r1);
                    break;
            case 2 :if (excluirFila(&l,&r1)) {
                        printf("\n\nElemento excluido: pop(%d)\n",r1.ra);
                    } else {printf("\n\nErro, pilha vazia ");} 
                    break;
            case 3 :listaFila(&l); getchar(); break;
            case 4 : printf("Todos os dados serão perdidos, continua (y/n) ? ");
                    scanf(" %c",&cont); if (cont=='y' || cont == 'Y') reinicializaFila(&l);
                    break;
            case 5 :printf("\n\ntamanho da pilha %d \n",tamanhoFila(&l)); 
            break;
            case 0 :printf("\n\nHasta la vista, Baby\n\n");
                    break;
            default :printf("\nOpcao invalida\n");
        }
    }
    return 0;
}
