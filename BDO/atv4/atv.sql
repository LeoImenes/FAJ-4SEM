/*exercicio 3*/

select *
from
  (    select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_fim_uso is not null

  union

    select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_inicio_uso is null  

minus

select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie
from st_dispositivo desp
  full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
  full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
  full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_inicio_uso is not null and desp_emp.d_fim_uso is null
) order by id_dispositivo ;



/*exercicio 4*/

select count(s_nome), s_nome
from
  (    select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_fim_uso is not null

  union all

    select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_inicio_uso is null  

minus

select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie
from st_dispositivo desp
  full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
  full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
  full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
where desp.s_ativo = 'S' and mod_desp.s_ativo = 'S' and desp_emp.d_inicio_uso is not null and desp_emp.d_fim_uso is null
) group by s_nome;

/*exercicio 5*/

select s_nome, count(s_ativo), s_ativo
from
  (    select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie, mod_desp.s_ativo
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where  desp_emp.d_fim_uso is not null

  union all

    select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie, mod_desp.s_ativo
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where  desp_emp.d_inicio_uso is null  

minus

select desp.id_dispositivo, mod_desp.s_nome, desp.s_numero_serie, mod_desp.s_ativo
from st_dispositivo desp
  full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
  full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
  full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
where  desp_emp.d_inicio_uso is not null and desp_emp.d_fim_uso is null
) group by s_nome, s_ativo;




/*exercicio 6*/
select *
from
  (    select nvl(emp.s_nome,'Em estoque') as Empresa, mod_desp.s_nome as Dispositivo , desp.s_numero_serie
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_fim_uso is not null

  union all

    select nvl(emp.s_nome,'Em estoque') , mod_desp.s_nome  , desp.s_numero_serie
    from st_dispositivo desp
      full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
      full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
      full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
    where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_inicio_uso is null and desp.s_numero_serie is not null 

minus

select nvl(emp.s_nome,'Em estoque') , mod_desp.s_nome  , desp.s_numero_serie
from st_dispositivo desp
  full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
  full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
  full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa)
where desp.s_ativo = 'S' and mod_desp.s_ativo  = 'S' and desp_emp.d_inicio_uso is not null and desp_emp.d_fim_uso is null
);




/*exercicio 7*/

create view vw_dispositivo_empresa
as
  select desp.id_dispositivo id_dispositivo , mod_desp.s_nome modelo , desp.s_numero_serie numero_serie, desp.s_ativo status, nvl(emp.s_nome,'Em estoque') locacao, desp_emp.d_inicio_uso as inicio_locacao, desp_emp.d_fim_uso as fim_locacao
  from st_dispositivo desp
    full outer join st_modelo_dispositivo mod_desp on (mod_desp.id_modelo_dispositivo = desp.id_modelo_dispositivo)
    full outer join st_dispositivo_empresa desp_emp on (desp.id_dispositivo = desp_emp.id_dispositivo)
    full outer join st_empresa emp on (emp.id_empresa = desp_emp.id_empresa);

/*exercicio 8*/

/*exercicio 3*/

select *
from
  (    select id_dispositivo, modelo, numero_serie
    from vw_dispositivo_empresa
    where status = 'S' and fim_locacao is not null

  union

    select id_dispositivo, modelo, numero_serie
    from vw_dispositivo_empresa
    where  status = 'S' and inicio_locacao is null  

minus

select id_dispositivo, modelo, numero_serie
from vw_dispositivo_empresa
where status = 'S' and (inicio_locacao is not null and fim_locacao is null)
) order by id_dispositivo ;

/*exercicio 4*/

select count(modelo), modelo
from
  (    select id_dispositivo, modelo, numero_serie
    from vw_dispositivo_empresa
    where status = 'S' and fim_locacao is not null

  union

    select id_dispositivo, modelo, numero_serie
    from vw_dispositivo_empresa
    where  status = 'S' and inicio_locacao is null  

minus

select id_dispositivo, modelo, numero_serie
from vw_dispositivo_empresa
where status = 'S' and (inicio_locacao is not null and fim_locacao is null)
) group by modelo ;

/*exercicio 5*/

select modelo, count(status), status
from (
    select *
    from vw_dispositivo_empresa
    where status = 'S'
  union
    select *
    from vw_dispositivo_empresa
    where inicio_locacao is null  
minus
select *
from vw_dispositivo_empresa
where (inicio_locacao is not null and fim_locacao is null)
) where modelo is not null and status is not null group by modelo, status ;

/*exercicio 6*/
  select id_dispositivo, modelo, locacao
  from (
      select *
      from vw_dispositivo_empresa
      where status = 'S'
    union
      select *
      from vw_dispositivo_empresa
      where inicio_locacao is null  
)

union

  select id_dispositivo, modelo, locacao
  from(
    select *
    from vw_dispositivo_empresa
    where inicio_locacao is not null and fim_locacao is not null
    minus
select *
from vw_dispositivo_empresa
where inicio_locacao is not null and fim_locacao is  null
);


    