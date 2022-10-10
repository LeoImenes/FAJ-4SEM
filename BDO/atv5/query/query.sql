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
select id_veiculo,data, count(horimetro) from DADOS_RASTREADOR group by id_veiculo, data ;

select v.id_veiculo,v.numero_frota,v.modelo,dh.trab_hora, td.trab_dia from veiculo v
full outer join
(select DADOS_hora.id_veiculo ,sum(DADOS_hora.TEMPO_MOVIMENTO + DADOS_hora.TEMPO_HIDRAULICO + DADOS_hora.TEMPO_MOV_HIDRAULICO + DADOS_hora.TEMPO_PARADO_LIGADO) as TRAB_HORA 
from DADOS_hora
group by id_veiculo) dh
on v.id_veiculo = dh.id_veiculo
full outer join 
(select id_veiculo,sum(dados_dia.TEMPO_MOVIMENTO + DADOS_Dia.TEMPO_HIDRAULICO + DADOS_Dia.TEMPO_MOV_HIDRAULICO + DADOS_Dia.TEMPO_PARADO_LIGADO) as TRAB_DIA 
from DADOS_Dia  group by id_veiculo) td
on v.id_veiculo = td.id_veiculo
;
