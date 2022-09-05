select Disciplina.nome 
from Disciplina inner join Cursa on (Disciplina.codigo = Cursa.codigo)
inner join Aluno on (Aluno.ra = Cursa.ra)
where Aluno.nome = 'Jos� da Silva';



select Aluno.*, professor.nome 
from Aluno 
Full OUTER join Professor professor on (professor.cpf = Aluno.orientador);

select Disciplina.nome 
from Disciplina inner join Cursa on (Disciplina.codigo = Cursa.codigo)
inner join Aluno on (Aluno.ra = Cursa.ra)
where Aluno.nome = 'Jos� da Silva';

select nome from aluno;


/*Exercicio 5*/
select Aluno.nome as Aluno, 
Cidade.nome as cidade from Aluno 
left join Cidade on Cidade.codigo = Aluno.codigo_cidade 
where Aluno.orientador = 
(select  professor  
from Disciplina  
where dia = 'Segunda-feira' FETCH FIRST 1 ROWS ONLY);

/*Exercicio 6*/

SELECT 
(select disciplina.nome from Disciplina 
where Dependente.disciplina = disciplina.codigo) as Materia,
(select disciplina.nome from Disciplina 
where dependente.pre_requisito = disciplina.codigo) as Pre_Requisito 
from dependente;

select materia.nome as Materia, 
pre_requisito.nome as Pre_requisito
from dependente 
join Disciplina materia on (materia.codigo = dependente.disciplina)
join Disciplina pre_requisito on (pre_requisito.codigo = dependente.pre_requisito);

/*Exercicio 7*/

select 
(select Disciplina.nome 
from disciplina 
where Dependente.disciplina = Disciplina.codigo) as Disciplina
from Dependente 
where pre_requisito = 
(select codigo 
from Disciplina 
where nome = 'Banco de Dados I');

select materia.nome as Materia
from dependente 
join Disciplina materia on (materia.codigo = dependente.disciplina)
where pre_requisito = 
(select codigo 
from Disciplina 
where nome = 'Banco de Dados I');

/*Exercicio 8*/

/* select professor.nome 
from Disciplina 
join Professor professor 
on (Disciplina.professor = professor.cpf)
where dia = 'Quarta-feira'; */

select Professor.nome 
from Professor where cpf = 
(SELECT Aluno.orientador from Aluno where aluno.codigo_cidade = 
(select Cidade.codigo from Cidade where Cidade.nome = 'Vinhedo' FETCH FIRST 1 ROWS ONLY)
FETCH FIRST 1 ROWS ONLY) and cpf = 
(select Disciplina.professor from disciplina where dia = 'Quarta-feira' );

SELECT Professor.nome, Disciplina.dia from professor 
inner join Disciplina on (Disciplina.professor = Professor.cpf)
inner join Aluno on (Aluno.orientador = Professor.cpf)
inner join Cidade on (Cidade.codigo = aluno.codigo_cidade);

select * from Disciplina;


/*Exercicio 9*/

select aluno.nome 
from Cursa 
join Aluno aluno on (aluno.ra = Cursa.ra)
where codigo = 
(select disciplina.codigo 
from Disciplina 
where Disciplina.nome = 'Banco de Dados I');

/*Exercicio 10*/

Select Disciplina.nome 
from Disciplina 
where not exists 
(Select Dependente.pre_requisito from Dependente 
where Dependente.disciplina = disciplina.codigo );

/*Exercicio 11*/
Select Disciplina.nome, Disciplina.codigo
from Disciplina 
where exists 
(Select Dependente.pre_requisito from Dependente 
where dependente.pre_requisito = disciplina.codigo)
and exists(Select Dependente.pre_requisito from Dependente 
where dependente.disciplina= disciplina.codigo) ;



/*Exercicio 12*/
select Aluno.* from Aluno inner join Professor on (Professor.cpf = aluno.orientador);


/*Exercicio 13*/

select Professor.nome from Professor where salario = 
(Select max(salario) from Professor) ;

Select Professor.nome from Professor where salario = 
(Select salario from Professor order by salario desc FETCH FIRST 1 ROWS ONLY);

/*Exercicio 14*/

Select AVG(salario) from Professor;


/*Exercicio 15*/
Select count(Disciplina.nome) as Quantidade, Professor.nome 
from Disciplina  
join Professor professor on (professor.cpf = disciplina.professor)
where Disciplina.professor = professor.cpf group by Professor.nome;

/*Exercicio 16*/

select count(aluno.nome) as Quantidade_Aluno, Professor.nome
from Aluno  join 
Professor professor 
on (professor.cpf = Aluno.orientador)group by professor.nome;


/*Exercicio 17*/
select Aluno.*, professor.nome 
from Aluno 
Full OUTER join Professor professor on (professor.cpf = Aluno.orientador);




select Professor.nome 
from Professor where cpf = (SELECT Aluno.orientador from Aluno where aluno.codigo_cidade = 
(select Cidade.codigo from Cidade where Cidade.nome = 'Vinhedo' FETCH FIRST 1 ROWS ONLY)
FETCH FIRST 1 ROWS ONLY) and cpf = 
(select Disciplina.professor from disciplina where dia = 'Quarta-feira' );

select aluno.nome 
from Cursa 
join Aluno aluno on (aluno.ra = Cursa.ra)
where codigo = 
(select disciplina.codigo 
from Disciplina 
where Disciplina.nome = 'Banco de Dados I');

Select Disciplina.nome 
from Disciplina 
where not exists 
(Select Dependente.pre_requisito from Dependente 
where Dependente.disciplina = disciplina.codigo );

