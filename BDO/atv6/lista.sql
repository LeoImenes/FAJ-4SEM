create table ALUNOS
(
    COD_ALUNO NUMBER,
    RA VARCHAR2(20),
    DATA_NASCIMENTO DATE,
    ENDERECO VARCHAR2(4000),
    CURSO VARCHAR2(60),
    NOME VARCHAR2(128)
)

alter table alunos add constraint XPKALUNOS Primary Key (COD_ALUNO);

CREATE table CURSAM
(
    COD_ALUNO NUMBER,
    COD_DISCIPLINA NUMBER
)

alter table CURSAM add constraint XPKCURSAM Primary Key (COD_ALUNO,COD_DISCIPLINA);
alter table CURSAM add constraint FK_ALUNOS_CURSAM Foreign Key	(COD_ALUNO) References ALUNOS(COD_ALUNO);

CREATE table CURSARAM
(
    DATA_CONCLUSAO DATE,
    FREQUENCIA NUMBER,
    NOTA NUMBER,
    SITUACAO VARCHAR2(1),
    COD_ALUNO NUMBER,
    COD_DISCIPLINA NUMBER
);

alter table CURSARAM add constraint XPKCURSARAM Primary Key	(DATA_CONCLUSAO,COD_ALUNO,COD_DISCIPLINA);
alter table CURSARAM add constraint FK_ALUNOS_CURSARAM Foreign Key	(COD_ALUNO) References ALUNOS(COD_ALUNO);


CREATE table DISCIPLINAS
(
    COD_DISCIPLINA NUMBER,
    NOME VARCHAR2(128),
    NUMERO_CREDITOS NUMBER
);

alter table DISCIPLINAS add constraint XPKDISCIPLINAS Primary Key (COD_DISCIPLINA);
alter table CURSARAM add constraint FK_DISCIPLINAS_CURSARAM Foreign Key	(COD_DISCIPLINA) References DISCIPLINAS(COD_DISCIPLINA);
alter table CURSAM add constraint FK_DISCIPLINAS_CURSAM Foreign Key	(COD_DISCIPLINA) References DISCIPLINAS(COD_DISCIPLINA);

/* exercicio 1 */
drop SEQUENCE SEQ_ALUNO;
 
CREATE SEQUENCE SEQ_ALUNO
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

drop SEQUENCE SEQ_DISCIPLINA;
 
CREATE SEQUENCE SEQ_DISCIPLINA
increment by 1 
start with 1
MAXVALUE 999999999999
NOCYCLE;

/*exercicio 2*/
create or replace trigger PK_INSERT_ALUNO
BEFORE INSERT ON ALUNOS
FOR EACH ROW
BEGIN
    SELECT SEQ_ALUNO.NEXTVAL into :new.cod_aluno from dual;
    end;
    
    
create or replace trigger PK_INSERT_DISCIPLINA
BEFORE INSERT ON Disciplinas
FOR EACH ROW
BEGIN
    SELECT SEQ_DISCIPLINA.NEXTVAL into :new.COD_DISCIPLINA from dual;
    end;
    
    
/*exercicio 3*/
select * from alunos;

    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('11920218','22/05/2001','Rua que sobe', 'Analise de Sistemas','Alberto Silva');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('11920978','10/05/2001','Rua que sobe', 'Analise de Sistemas','Josenildo Silva');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('11920979','10/05/2001','Rua das andorinhas ', 'Analise de Sistemas','Roberto Alves');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('11920980','10/05/2001','Rua XV de Novembro', 'Letras','Reginaldo da Silva');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('12312312','10/05/2001','Rua Presidente Vargas', 'Psicologia','Amanda Nunes');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('42312312','10/05/2001','Rua dos ypes', 'Fisica','Sofia de Oliveira');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('13321232','10/05/2001','Rua Marechal Deodoro da Fonseca', 'Analise de Sistemas','Francisco Silva');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('12332123','10/05/2001','Rua Floriano Peixoto', 'Analise de Sistemas','Jose Alves');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('12333112','10/05/2001','Rua Panorama', 'Letras','Guilherme da Silva');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('12333212','10/05/2001','Rua Florianopolis', 'Administracao','Hudson Arantes');
    insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('42123123','10/05/2001','Rua Duque de Caixias', 'Analise de Sistemas','Cleisson Silva');
    
select * from disciplinas;
    
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Matematica', 25);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Fisica', 30);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Quimica', 40);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Portugues', 25);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('POO', 30);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Banco de dados', 40);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Literatura', 25);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Estatisica', 30);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Algebra', 40);
    insert into disciplinas(disciplinas.nome,disciplinas.numero_creditos) values ('Redes', 25);

/*exercicio 4*/
insert into cursam(cod_aluno,cod_disciplina) values (2,2);
insert into cursam(cod_aluno,cod_disciplina) values (2,3);
insert into cursam(cod_aluno,cod_disciplina) values (4,4);
insert into cursam(cod_aluno,cod_disciplina) values (5,6);
insert into cursam(cod_aluno,cod_disciplina) values (10,10);

create view vw_aluno as 
select
 a.nome as Aluno, a.ra , d.nome as Disciplina
 from cursam c
 join alunos a on (a.cod_aluno = c.cod_aluno)
 join disciplinas d on(d.cod_disciplina = c.cod_disciplina);

 select * from vw_aluno;


/*exercicio 5*/
create or replace FUNCTION Status_Aluno (
param_nota IN number, param_frequencia IN  number) 
RETURN VARCHAR AS

v_nota number;
v_frequencia number;

BEGIN
v_nota := param_nota;
v_frequencia := param_frequencia;

if v_nota >= 6 and v_frequencia >= 0.75
    then return 'A';
else 
    return 'R';
    end if;
END;

select status_aluno(6,0.74),status_aluno(6,0.75),status_aluno(7,7),status_aluno(5,0.75) from dual;

/*exercicio 6*/

select * from cursaram;

insert into cursaram values ('22/08/2022',1,10,'R',3,2);
insert into cursaram values ('12/12/2022',0.1,6,'A',2,4);
insert into cursaram values ('03/05/2023',0.50,2.64,'A',4,2);
insert into cursaram values ('04/02/2023',1,3,'A',5,7);
insert into cursaram values ('22/02/2023',0.749,5.9,'A',9,10);

create or replace procedure Proc_Stats_Aluno
as 

Cursor c1 is Select Nota,frequencia,cod_aluno from cursaram;

begin

    for i in c1
    loop
        update cursaram set situacao = ( 
        select status_aluno(i.nota,i.frequencia )from cursaram where cod_aluno = i.cod_aluno and nota = i.nota and frequencia = i.frequencia )
         where cod_aluno = i.cod_aluno and nota = i.nota and frequencia = i.frequencia ;
    end loop;
 end ;  
 
 exec Proc_Stats_Aluno;
 
 select * from cursaram;
 
/*exercicio 7*/
drop trigger  trg_situacao_aluno;
create or replace trigger trg_situacao_aluno
before insert on cursaram
for each row
begin
    select status_aluno(:new.nota,:new.frequencia) into :new.situacao from cursaram where cod_aluno = :new.cod_aluno;
end;

insert into cursaram(data_conclusao,frequencia,nota,cod_aluno,cod_disciplina) values ('22/02/2023',0.749,5.9,6,3);

 /*exercicio 8*/
insert into cursam values (21,1);
insert into cursam values (41,21);
insert into cursam values (42,24);
insert into cursam values (43,23);

insert into alunos values (DEFAULT,'2341231','22/04/2001','Rua das Alamedas','Astrofisica','Amanda Nunes');
insert into disciplinas values (DEFAULT,'Algebra',70);
 create or replace trigger CURSAM_REMOVE
 after insert on cursaram  
 for each row
 begin
   delete from cursam where cod_aluno = :new.cod_aluno;
 end;
 
 select * from cursaram;
 insert into cursaram values ('22/02/2023',0.55,5.9,'A',42,24);
 
/*exercicio 9*/
 create unique INDEX  INX_RA_ALUNO on alunos(ra);
 
  insert into alunos(ra,data_nascimento,endereco,curso,nome) values ('11920978','10/05/2001','Rua que sobe', 'Analise de Sistemas','Josenildo Silva');
 






