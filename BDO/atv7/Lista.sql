CREATE TABLE CATEGORIAS
(
       COD_CATEGORIA NUMBER NOT NULL,
       DESCRICAO VARCHAR2(80) NOT NULL,
       PRECO_LOCACAO NUMBER(5,2) NOT NULL
);

ALTER TABLE CATEGORIAS
       ADD
( CONSTRAINT XPKCATEGORIAS PRIMARY KEY
(COD_CATEGORIA) ) ;

CREATE TABLE CLIENTE
(
       COD_CLIENTE NUMBER NOT NULL,
       NOME VARCHAR2(128) NOT NULL,
       RUA VARCHAR2(100) NOT NULL,
       NUMERO NUMBER NOT NULL,
       COMPLEMENTO VARCHAR2(100) NULL,
       BAIRRO VARCHAR2(100) NOT NULL,
       CIDADE VARCHAR2(50) NOT NULL
);

ALTER TABLE CLIENTE
       ADD
( CONSTRAINT XPKCLIENTE PRIMARY KEY
(COD_CLIENTE) ) ;
CREATE TABLE FILMES
(
       COD_FILME NUMBER NOT NULL,
       DESCRICAO VARCHAR2(128) NOT NULL,
       DURACAO NUMBER NOT NULL,
       COD_CATEGORIA NUMBER NOT NULL
);

ALTER TABLE FILMES
       ADD
( CONSTRAINT XPKFILMES PRIMARY KEY
(COD_FILME) ) ;

CREATE TABLE FITAS
(
       COD_FITA NUMBER NOT NULL,
       DESCRICAO VARCHAR2(60) NOT NULL,
       DATA_COMPRA DATE NOT NULL,
       COD_FILME NUMBER NOT NULL,
       DISPONIVEL VARCHAR2(1) NOT NULL
);

ALTER TABLE FITAS
       ADD
( CONSTRAINT XPKFITAS PRIMARY KEY
(COD_FITA) ) ;

CREATE TABLE LOCACAO
(
       COD_CLIENTE NUMBER NOT NULL,
       COD_FITA NUMBER NOT NULL,
       DATA_LOCACAO DATE NOT NULL,
       DATA_DEVOLUCAO DATE NULL,
       VALOR_LOCACAO NUMBER(5,2) NOT NULL
);

ALTER TABLE LOCACAO
       ADD
( CONSTRAINT XPKLOCACAO PRIMARY KEY
(COD_CLIENTE, 
              COD_FITA, DATA_LOCACAO) ) ;

ALTER TABLE FILMES
       ADD
( CONSTRAINT FK_CATEGORIA_FILME
              FOREIGN KEY
(COD_CATEGORIA)
                             REFERENCES CATEGORIAS ) ;

ALTER TABLE FITAS
       ADD
( CONSTRAINT FK_FILME_FITA
              FOREIGN KEY
(COD_FILME)
                             REFERENCES FILMES ) ;

ALTER TABLE LOCACAO
       ADD
( CONSTRAINT FK_FITA_LOCACAO
              FOREIGN KEY
(COD_FITA)
                             REFERENCES FITAS ) ;

ALTER TABLE LOCACAO
       ADD
( CONSTRAINT FK_CLIENTE_LOCACAO
              FOREIGN KEY
(COD_CLIENTE)
                             REFERENCES CLIENTE ) ;

/*Exercicio 1 */
create sequence SEQ_ADD_CLIENTE
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

SELECT SEQ_ADD_CLIENTE.NEXTVAL
from dual;

CREATE SEQUENCE SEQ_ADD_FILME
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

SELECT SEQ_ADD_FILME.NEXTVAL
from dual;

CREATE SEQUENCE SEQ_ADD_CATEGORIA
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

SELECT SEQ_ADD_CATEGORIA.NEXTVAL
from dual;

CREATE SEQUENCE SEQ_ADD_FITAS
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

SELECT SEQ_ADD_FITAS.NEXTVAL
from dual;

/*Exercicio 2 */
Create or replace TRIGGER PK_GEN_CLIENTE
BEFORE
INSERT ON
CLIENTE
FOR
EACH
ROW
BEGIN
       SELECT SEQ_ADD_CLIENTE.NEXTVAL
       into
:new.cod_cliente from dual;
end;

Create or replace TRIGGER PK_GEN_FILME
BEFORE
INSERT ON
FILMES
FOR
EACH
ROW
BEGIN
       SELECT SEQ_ADD_FILME.NEXTVAL
       into
:new.cod_filme from dual;
end;

Create or replace TRIGGER PK_GEN_CATEGORIA
BEFORE
INSERT ON
CATEGORIAS
FOR
EACH
ROW
BEGIN
       SELECT SEQ_ADD_CATEGORIA.NEXTVAL
       into
:new.cod_categoria from dual;
end;

Create or replace TRIGGER PK_GEN_FITAS
BEFORE
INSERT ON
FITAS
FOR
EACH
ROW
BEGIN
       SELECT SEQ_ADD_FITAS.NEXTVAL
       into
:new.cod_fita from dual;
end;
    
/*exercicio 3*/

/*clientes*/
desc cliente;
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Jose Campus', 'Rua das Oliveiras', 243, 'Apartamento dos ypes', 'Bairro Alvorada', 'Itapetininga' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Elosangela Gomes', 'Rua das Amoras', 243, 'Em frente ao Clube', 'Bairro do AlviNegros', 'Pirassununga' );


/*categorias*/
desc categorias;
insert into categorias
       (DESCRICAO,PRECO_LOCACAO)
values
       ('Terror', 24.60);
insert into categorias
       (DESCRICAO,PRECO_LOCACAO)
values
       ('Aventura', 19.90);
select *
from categorias;

/*filmes*/
desc filmes;
insert into filmes
       (descricao,duracao,cod_categoria)
values
       ('A freira', 2, 21);
insert into filmes
       (descricao,duracao,cod_categoria)
values
       ('Indiana Jones', 1.4, 22);
select *
from filmes;


/*fitas*/
desc fitas;
insert into fitas
       (DESCRICAO,DATA_COMPRA,COD_FILME,DISPONIVEL)
values
       ('A freira', '07/11/2022', 21, 'S');
insert into fitas
       (DESCRICAO,DATA_COMPRA,COD_FILME,DISPONIVEL)
values
       ('Indiana Jones', '02/11/2022', 21, 'N');
select *
from fitas;

/*exercicio 4*/

create view vw_Fita
as
       select ft.cod_fita, ft.descricao as Fita, fl.descricao as Filme, ct.descricao as categoria, ct.PRECO_LOCACAO
       from fitas fT, filmes fl, categorias ct
       where 
    ft.cod_filme = fl.cod_filme and
              fl.cod_categoria = ct.cod_categoria and
              ft.DISPONIVEL = 'S'
;

select *
from vw_Fita;
/*Ex 5 */

create or replace function fn_fita
(p_cod_fita in number)
RETURN  number
is

preco number;

CURSOR c1
IS
SELECT preco_locacao
FROM vw_Fita
WHERE cod_fita = p_cod_fita;

Begin
       open c1;
       fetch c1
       into preco;
close c1;

return preco;

exception

when NO_DATA_FOUND then 
raise_application_error
(-20000, 'Fita não encontrada ou indisponível');

end ;

select fn_fita(44)
from dual;

/*EX 6 */

desc locacao;

create or replace TRIGGER tgr_locacao
before
insert on
LOCACAO
for
each
row
BEGIN
       IF (to_char(:new.data_locacao, 'D') = 1 or to_char(:new.data_locacao, 'D') = 7 )  THEN 
      :new.valor_locacao :=
       (fn_fita
       (:new.cod_fita)*0.10) + fn_fita
       (:new.cod_fita)
;
ELSE
       :new.valor_locacao :=  fn_fita
(:new.cod_fita) ;

END
IF ;
    
END;

delete  from locacao;

insert into locacao
       (cod_cliente,cod_fita,data_locacao,data_devolucao)
values
       (21, 21, '12/11/2022', '11/12/2022');

select *
from locacao;

select fn_fita(21)
from dual
;
select to_char(locacao.data_locacao, 'D')
from locacao;

/*EX 6 */

desc locacao;

create or replace TRIGGER tgr_locacao
before
insert on
LOCACAO
for
each
row
BEGIN
       IF (to_char(:new.data_locacao, 'D') = 1 or to_char(:new.data_locacao, 'D') = 7 )  THEN 
      :new.valor_locacao :=
       (fn_fita
       (:new.cod_fita)*0.10) + fn_fita
       (:new.cod_fita)
;
ELSE
       :new.valor_locacao :=  fn_fita
(:new.cod_fita) ;

END
IF ;
    
END;

delete  from locacao;

insert into locacao
       (cod_cliente,cod_fita,data_locacao,data_devolucao)
values
       (21, 21, '12/11/2022', '11/12/2022');

select *
from locacao;

select fn_fita(21)
from dual
;
select to_char(locacao.data_locacao, 'D')
from locacao;


/*EX 7 */
create or replace trigger tgr_locacao_disponivel
after
insert on
locacao
for
each
row
begin
       update fitas set disponivel =  'N' where cod_fita = :old.cod_fita;
end;

select *
from locacao;
insert into locacao
       (cod_cliente,cod_fita,data_locacao,data_devolucao)
values
       (22, 44, '12/11/2022', '11/12/2022');

/*ex8*/
select *
from fitas;
create view vw_cliente
as
       select cliente.cod_cliente, cliente.nome, fitas.cod_fita, fitas.descricao
       from cliente , fitas , locacao
       where cliente.cod_cliente = locacao.cod_cliente
              and fitas.cod_fita = locacao.cod_fita;

select nome, count(cod_fita)
from vw_cliente
group by nome;

select *
from locacao;

update locacao set valor_locacao = locacao.valor_locacao + 10 where cod_cliente = 21;

/*ex9*/
create table Conta
(
       numero integer not null,
       Saldo number,
       CHECK (saldo >=0)

)

create table Poupanca
(
       numero integer not null,
       Saldo number ,
       CHECK (saldo >=0)
)

insert into conta
values
       (100, 700);
insert into conta
values
       (200, 300);
insert into conta
values
       (300, 15000);

insert into poupanca
values
       (300, 5200);
insert into poupanca
values
       (100, 0);
insert into poupanca
values
       (200, 2.700);


UPDATE Conta SET saldo = saldo - 3000 WHERE numero = 300;
UPDATE Conta SET saldo = saldo - 500 WHERE numero = 200;
UPDATE Conta SET saldo = saldo - 800 WHERE numero = 100;



insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Jose Campus', 'Rua das Oliveiras', 243, 'Apartamento dos ypes', 'Bairro Alvorada', 'Itapetininga' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Elosangela Gomes', 'Rua das Amoras', 243, 'Em frente ao Clube', 'Bairro do AlviNegros', 'Pirassununga' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Heloisa Silva' , 'Rua das Amoras', 152, 'Em frente ao Clube', 'Bairro do AlviNegros', 'Pirassununga' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Jefferson de Oliveira', 'Rua das Andorinas', 124, 'Em frente ao Clube', 'Parque Adolfo Gomes', 'Pirassununga' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Rodrigo Moraes', 'Rua das Oliveira', 124, 'Em frente ao Sindicato dos Cabelereiro', 'Bairro Nova Campinas', 'Campinas' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Roberto Campos', 'Rua Dirceu de Oliveira', 203, 'Nao informado', 'Nova Sao Paulo', 'Sao Paulo' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Silvio Abravanel'	, 'Rua Eduardo Gomes'	, 223, 'Nao informado', 'Jardim Ypes'	, 'São Paulo' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Luis Inacio'	, 'Marginal Tiete'	, 213	, 'ABC Paulista', 'Bairro Taboao', 'São Bernardo do Campo' );
insert into cliente
       (NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE)
values
       ('Jair Messias', 'Rua das Laranjeiras'	, 222	, 'Nao informado', 'Bairro da Republica', 'Sao Paulo' );

