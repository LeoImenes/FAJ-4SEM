CREATE TABLE CATEGORIAS (
       COD_CATEGORIA        NUMBER       NOT NULL,
       DESCRICAO            VARCHAR2(80) NOT NULL,
       PRECO_LOCACAO        NUMBER(5,2)  NOT NULL
);

ALTER TABLE CATEGORIAS
       ADD  ( CONSTRAINT XPKCATEGORIAS PRIMARY KEY (COD_CATEGORIA) ) ;

CREATE TABLE CLIENTE (
       COD_CLIENTE          NUMBER        NOT NULL,
       NOME                 VARCHAR2(128) NOT NULL,
       RUA                  VARCHAR2(100) NOT NULL,
       NUMERO               NUMBER        NOT NULL,
       COMPLEMENTO          VARCHAR2(100) NULL,
       BAIRRO               VARCHAR2(100) NOT NULL,
       CIDADE               VARCHAR2(50)  NOT NULL
);

ALTER TABLE CLIENTE
       ADD  ( CONSTRAINT XPKCLIENTE PRIMARY KEY (COD_CLIENTE) ) ;
CREATE TABLE FILMES (
       COD_FILME            NUMBER        NOT NULL,
       DESCRICAO            VARCHAR2(128) NOT NULL,
       DURACAO              NUMBER        NOT NULL,
       COD_CATEGORIA        NUMBER        NOT NULL
);

ALTER TABLE FILMES
       ADD  ( CONSTRAINT XPKFILMES PRIMARY KEY (COD_FILME) ) ;

CREATE TABLE FITAS (
       COD_FITA             NUMBER       NOT NULL,
       DESCRICAO            VARCHAR2(60) NOT NULL,
       DATA_COMPRA          DATE         NOT NULL,
       COD_FILME            NUMBER       NOT NULL,
       DISPONIVEL           VARCHAR2(1)  NOT NULL
);

ALTER TABLE FITAS
       ADD  ( CONSTRAINT XPKFITAS PRIMARY KEY (COD_FITA) ) ;

CREATE TABLE LOCACAO (
       COD_CLIENTE          NUMBER      NOT NULL,
       COD_FITA             NUMBER      NOT NULL,
       DATA_LOCACAO         DATE        NOT NULL,
       DATA_DEVOLUCAO       DATE        NULL,
       VALOR_LOCACAO        NUMBER(5,2) NOT NULL
);

ALTER TABLE LOCACAO
       ADD  ( CONSTRAINT XPKLOCACAO PRIMARY KEY (COD_CLIENTE, 
              COD_FITA, DATA_LOCACAO) ) ;

ALTER TABLE FILMES
       ADD  ( CONSTRAINT FK_CATEGORIA_FILME
              FOREIGN KEY (COD_CATEGORIA)
                             REFERENCES CATEGORIAS ) ;

ALTER TABLE FITAS
       ADD  ( CONSTRAINT FK_FILME_FITA
              FOREIGN KEY (COD_FILME)
                             REFERENCES FILMES ) ;

ALTER TABLE LOCACAO
       ADD  ( CONSTRAINT FK_FITA_LOCACAO
              FOREIGN KEY (COD_FITA)
                             REFERENCES FITAS ) ;

ALTER TABLE LOCACAO
       ADD  ( CONSTRAINT FK_CLIENTE_LOCACAO
              FOREIGN KEY (COD_CLIENTE)
                             REFERENCES CLIENTE ) ;
                             
/*Exercicio 1 */
create sequence SEQ_ADD_CLIENTE
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

 SELECT SEQ_ADD_CLIENTE.NEXTVAL from dual;
 
CREATE SEQUENCE SEQ_ADD_FILME
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

SELECT SEQ_ADD_FILME.NEXTVAL from dual;

CREATE SEQUENCE SEQ_ADD_CATEGORIA
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

SELECT SEQ_ADD_CATEGORIA.NEXTVAL from dual;

CREATE SEQUENCE SEQ_ADD_FITAS
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

SELECT SEQ_ADD_FITAS.NEXTVAL from dual;

/*Exercicio 2 */
Create or replace TRIGGER PK_GEN_CLIENTE
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
    SELECT SEQ_ADD_CLIENTE.NEXTVAL into :new.cod_cliente from dual;
    end;
    
Create or replace TRIGGER PK_GEN_FILME
BEFORE INSERT ON FILMES
FOR EACH ROW
BEGIN
    SELECT SEQ_ADD_FILME.NEXTVAL into :new.cod_filme from dual;
    end;
    
Create or replace TRIGGER PK_GEN_CATEGORIA
BEFORE INSERT ON CATEGORIAS
FOR EACH ROW
BEGIN
    SELECT SEQ_ADD_CATEGORIA.NEXTVAL into :new.cod_categoria from dual;
    end;
    
Create or replace TRIGGER PK_GEN_FITAS
BEFORE INSERT ON FITAS
FOR EACH ROW
BEGIN
    SELECT SEQ_ADD_FITAS.NEXTVAL into :new.cod_fita from dual;
    end;
    
/*exercicio 3*/

/*clientes*/
desc cliente;
insert into cliente(NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE) values ('Jose Campus','Rua das Oliveiras',243,'Apartamento dos ypes', 'Bairro Alvorada','Itapetininga' );
insert into cliente(NOME,RUA,NUMERO,COMPLEMENTO,BAIRRO,CIDADE) values ('Elosangela Gomes','Rua das Amoras',243,'Em frente ao Clube', 'Bairro do AlviNegros','Pirassununga' );


/*categorias*/
desc categorias;
insert into categorias(DESCRICAO,PRECO_LOCACAO) values ('Terror', 24.60);
insert into categorias(DESCRICAO,PRECO_LOCACAO) values ('Aventura', 19.90);
select * from categorias;

/*filmes*/
desc filmes;
insert into filmes(descricao,duracao,cod_categoria) values ('A freira',2,21);
insert into filmes(descricao,duracao,cod_categoria) values ('Indiana Jones',1.4,22);
select * from filmes;


/*fitas*/
desc fitas;
insert into fitas(DESCRICAO,DATA_COMPRA,COD_FILME,DISPONIVEL) values ('A freira','07/11/2022',21,'S');
insert into fitas(DESCRICAO,DATA_COMPRA,COD_FILME,DISPONIVEL) values ('Indiana Jones','02/11/2022',21,'N');
select * from fitas;

/*exercicio 4*/
create view vw_Fita as
    select ft.descricao as Fita,fl.descricao as Filme,ct.descricao as categoria,ct.PRECO_LOCACAO
    from fitas fT, filmes fl, categorias ct 
    where 
    ft.cod_filme = fl.cod_filme and
    fl.cod_categoria = ct.cod_categoria and
    ft.DISPONIVEL = 'S'
    ;
    
select * from vw_Fita where 

/*Exercicio 5 */
