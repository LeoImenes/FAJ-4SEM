select * from dados_dia;
select * from DADOS_HORA;
select * from DADOS_RASTREADOR;
select * from VEICULO;


/*Trabalho por dia e hora */ 
select id_veiculo,sum(DADOS_hora.TEMPO_MOVIMENTO + DADOS_hora.TEMPO_HIDRAULICO + DADOS_hora.TEMPO_MOV_HIDRAULICO + DADOS_hora.TEMPO_PARADO_LIGADO) as TRAB_HORA from DADOS_hora  group by id_veiculo;
select id_veiculo,sum(dados_dia.TEMPO_MOVIMENTO + DADOS_Dia.TEMPO_HIDRAULICO + DADOS_Dia.TEMPO_MOV_HIDRAULICO + DADOS_Dia.TEMPO_PARADO_LIGADO) as TRAB_DIA from DADOS_Dia  group by id_veiculo;
/*Ligado por hora e dia*/
select id_veiculo, sum(DADOS_HORA.TEMPO_MOVIMENTO + DADOS_HORA.TEMPO_HIDRAULICO + DADOS_HORA.TEMPO_MOV_HIDRAULICO + DADOS_HORA.TEMPO_PARADO_LIGADO + DADOS_HORA.TEMPO_LIGADO)as LIG_HORA from DADOS_HORA group by id_veiculo;
select id_veiculo, sum(DADOS_dia.TEMPO_MOVIMENTO + DADOS_dia.TEMPO_HIDRAULICO + DADOS_dia.TEMPO_MOV_HIDRAULICO + DADOS_dia.TEMPO_PARADO_LIGADO + DADOS_dia.TEMPO_LIGADO)as LIG_DIA from DADOS_dia group by id_veiculo;
/*Horimetro do Rastreador*/
select distinct id_veiculo, horimetro from DADOS_RASTREADOR order by id_veiculo ;

select v.id_veiculo,v.numero_frota,v.modelo,dh.trab_hora, td.trab_dia, lh.lig_hora, ldia.lig_dia, hr.horimetro from veiculo v
full outer join
(select DADOS_hora.id_veiculo ,sum(DADOS_hora.TEMPO_MOVIMENTO + DADOS_hora.TEMPO_HIDRAULICO + DADOS_hora.TEMPO_MOV_HIDRAULICO + DADOS_hora.TEMPO_PARADO_LIGADO) as TRAB_HORA 
from DADOS_hora
group by id_veiculo) dh
on v.id_veiculo = dh.id_veiculo
full outer join 
(select id_veiculo,sum(dados_dia.TEMPO_MOVIMENTO + DADOS_Dia.TEMPO_HIDRAULICO + DADOS_Dia.TEMPO_MOV_HIDRAULICO + DADOS_Dia.TEMPO_PARADO_LIGADO) as TRAB_DIA 
from DADOS_Dia  group by id_veiculo) td
on v.id_veiculo = td.id_veiculo
full outer join 
(select id_veiculo, sum(DADOS_HORA.TEMPO_MOVIMENTO + DADOS_HORA.TEMPO_HIDRAULICO + DADOS_HORA.TEMPO_MOV_HIDRAULICO + DADOS_HORA.TEMPO_PARADO_LIGADO + DADOS_HORA.TEMPO_LIGADO)as LIG_HORA 
from DADOS_HORA group by id_veiculo)lh
on v.id_veiculo = lh.id_veiculo
full outer join (
select id_veiculo, sum(DADOS_dia.TEMPO_MOVIMENTO + DADOS_dia.TEMPO_HIDRAULICO + DADOS_dia.TEMPO_MOV_HIDRAULICO + DADOS_dia.TEMPO_PARADO_LIGADO + DADOS_dia.TEMPO_LIGADO)as LIG_DIA 
from DADOS_dia group by id_veiculo)ldia
on v.id_veiculo = ldia.id_veiculo
full outer JOIN
(select id_veiculo, horimetro as horimetro from DADOS_RASTREADOR) hr
on v.id_veiculo = hr.id_veiculo

;
select * from dados_dia;
select * from DADOS_HORA;
select * from DADOS_RASTREADOR;
select * from VEICULO;


/*Trabalho por dia e hora */ 
select id_veiculo,sum(DADOS_hora.TEMPO_MOVIMENTO + DADOS_hora.TEMPO_HIDRAULICO + DADOS_hora.TEMPO_MOV_HIDRAULICO + DADOS_hora.TEMPO_PARADO_LIGADO) as TRAB_HORA from DADOS_hora  group by id_veiculo;
select id_veiculo,sum(dados_dia.TEMPO_MOVIMENTO + DADOS_Dia.TEMPO_HIDRAULICO + DADOS_Dia.TEMPO_MOV_HIDRAULICO + DADOS_Dia.TEMPO_PARADO_LIGADO) as TRAB_DIA from DADOS_Dia  group by id_veiculo;
/*Ligado por hora e dia*/
select id_veiculo, sum(DADOS_HORA.TEMPO_MOVIMENTO + DADOS_HORA.TEMPO_HIDRAULICO + DADOS_HORA.TEMPO_MOV_HIDRAULICO + DADOS_HORA.TEMPO_PARADO_LIGADO + DADOS_HORA.TEMPO_LIGADO)as LIG_HORA from DADOS_HORA group by id_veiculo;
select id_veiculo, sum(DADOS_dia.TEMPO_MOVIMENTO + DADOS_dia.TEMPO_HIDRAULICO + DADOS_dia.TEMPO_MOV_HIDRAULICO + DADOS_dia.TEMPO_PARADO_LIGADO + DADOS_dia.TEMPO_LIGADO)as LIG_DIA from DADOS_dia group by id_veiculo;
/*Horimetro do Rastreador*/
select distinct data, id_veiculo, horimetro from DADOS_RASTREADOR order by id_veiculo ;

select * from (select v.id_veiculo,nvl('Com Dados ',null) as Status,v.numero_frota,v.modelo,dh.trab_hora, td.trab_dia, lh.lig_hora, ldia.lig_dia, hr.horimetro from veiculo v
join
(select DADOS_hora.id_veiculo ,sum(DADOS_hora.TEMPO_MOVIMENTO + DADOS_hora.TEMPO_HIDRAULICO + DADOS_hora.TEMPO_MOV_HIDRAULICO + DADOS_hora.TEMPO_PARADO_LIGADO) as TRAB_HORA 
from DADOS_hora
group by id_veiculo) dh
on v.id_veiculo = dh.id_veiculo
join 
(select id_veiculo,sum(dados_dia.TEMPO_MOVIMENTO + DADOS_Dia.TEMPO_HIDRAULICO + DADOS_Dia.TEMPO_MOV_HIDRAULICO + DADOS_Dia.TEMPO_PARADO_LIGADO) as TRAB_DIA 
from DADOS_Dia  group by id_veiculo) td
on v.id_veiculo = td.id_veiculo
join 
(select id_veiculo, sum(DADOS_HORA.TEMPO_MOVIMENTO + DADOS_HORA.TEMPO_HIDRAULICO + DADOS_HORA.TEMPO_MOV_HIDRAULICO + DADOS_HORA.TEMPO_PARADO_LIGADO + DADOS_HORA.TEMPO_LIGADO)as LIG_HORA 
from DADOS_HORA group by id_veiculo)lh
on v.id_veiculo = lh.id_veiculo
join (
select id_veiculo, sum(DADOS_dia.TEMPO_MOVIMENTO + DADOS_dia.TEMPO_HIDRAULICO + DADOS_dia.TEMPO_MOV_HIDRAULICO + DADOS_dia.TEMPO_PARADO_LIGADO + DADOS_dia.TEMPO_LIGADO)as LIG_DIA 
from DADOS_dia group by id_veiculo)ldia
on v.id_veiculo = ldia.id_veiculo
JOIN
(select distinct id_veiculo, horimetro from DADOS_RASTREADOR order by id_veiculo) hr
on v.id_veiculo = hr.id_veiculo 

union all

select v.id_veiculo,nvl('Sem Dados',null) as Status ,v.numero_frota,v.modelo,dh.trab_hora, td.trab_dia, lh.lig_hora, ldia.lig_dia, hr.horimetro from veiculo v
full outer join
(select DADOS_hora.id_veiculo ,sum(DADOS_hora.TEMPO_MOVIMENTO + DADOS_hora.TEMPO_HIDRAULICO + DADOS_hora.TEMPO_MOV_HIDRAULICO + DADOS_hora.TEMPO_PARADO_LIGADO) as TRAB_HORA 
from DADOS_hora
group by id_veiculo) dh
on v.id_veiculo = dh.id_veiculo
full outer join 
(select id_veiculo,sum(dados_dia.TEMPO_MOVIMENTO + DADOS_Dia.TEMPO_HIDRAULICO + DADOS_Dia.TEMPO_MOV_HIDRAULICO + DADOS_Dia.TEMPO_PARADO_LIGADO) as TRAB_DIA 
from DADOS_Dia  group by id_veiculo) td
on v.id_veiculo = td.id_veiculo
full outer join 
(select id_veiculo, sum(DADOS_HORA.TEMPO_MOVIMENTO + DADOS_HORA.TEMPO_HIDRAULICO + DADOS_HORA.TEMPO_MOV_HIDRAULICO + DADOS_HORA.TEMPO_PARADO_LIGADO + DADOS_HORA.TEMPO_LIGADO)as LIG_HORA 
from DADOS_HORA group by id_veiculo)lh
on v.id_veiculo = lh.id_veiculo
full outer join (
select id_veiculo, sum(DADOS_dia.TEMPO_MOVIMENTO + DADOS_dia.TEMPO_HIDRAULICO + DADOS_dia.TEMPO_MOV_HIDRAULICO + DADOS_dia.TEMPO_PARADO_LIGADO + DADOS_dia.TEMPO_LIGADO)as LIG_DIA 
from DADOS_dia group by id_veiculo)ldia
on v.id_veiculo = ldia.id_veiculo
full outer JOIN
(select distinct id_veiculo, horimetro from DADOS_RASTREADOR order by id_veiculo) hr
on v.id_veiculo = hr.id_veiculo where dh.trab_hora is null  and td.trab_dia is null and ldia.lig_dia is null and lh.lig_hora is null);

